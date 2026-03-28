/**
 * 分数の割り算.com - 計算ロジック & インタラクティブUI
 * 100% 日本語化された学習用計算機
 */

document.addEventListener('DOMContentLoaded', () => {
    // UI Elements
    const calcBtn = document.getElementById('calc-btn');
    const resultSection = document.getElementById('result-section');
    const resultSteps = document.getElementById('result-steps');
    const finalResult = document.getElementById('final-result');
    const resetBtn = document.getElementById('reset-btn');
    const copyBtn = document.getElementById('copy-btn');
    const historyList = document.getElementById('history-list');
    const historySection = document.getElementById('history-section');
    const printBtn = document.getElementById('print-btn');
    const darkModeBtn = document.getElementById('dark-mode-toggle');

    // Quiz Elements
    const quizProblem = document.getElementById('quiz-problem');
    const quizAnsN = document.getElementById('quiz-ans-n');
    const quizAnsD = document.getElementById('quiz-ans-d');
    const quizCheckBtn = document.getElementById('quiz-check-btn');
    const quizFeedback = document.getElementById('quiz-feedback');
    const nextQuizBtn = document.getElementById('next-quiz-btn');
    const levelBtns = document.querySelectorAll('.tab-btn');

    // State
    let currentLevel = 'easy'; // easy, medium, hard
    let currentQuizAnswer = null;
    let history = JSON.parse(localStorage.getItem('fracHistory') || '[]');

    // Initialization
    updateHistoryUI();
    generateQuiz();
    if (localStorage.getItem('fracTheme') === 'dark') document.body.classList.add('dark-mode');

    // Event Listeners
    calcBtn.addEventListener('click', calculate);
    resetBtn.addEventListener('click', resetCalculator);
    copyBtn.addEventListener('click', copyResult);
    printBtn.addEventListener('click', () => window.print());
    darkModeBtn.addEventListener('click', toggleTheme);
    quizCheckBtn.addEventListener('click', checkQuiz);
    nextQuizBtn.addEventListener('click', generateQuiz);

    levelBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            levelBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            currentLevel = btn.dataset.level;
            generateQuiz();
        });
    });

    // Core Logic
    function gcd(a, b) { return b === 0 ? Math.abs(a) : gcd(b, a % b); }
    function simplify(num, den) { const common = gcd(num, den); return [num / common, den / common]; }

    function formatFractionHtml(num, den) {
        if (den === 1) return `<span>${num}</span>`;
        return `
            <div style="display:inline-flex; flex-direction:column; align-items:center; vertical-align:middle; line-height:1;">
                <span style="border-bottom: 2px solid currentColor; padding: 0 4px; font-weight:700;">${num}</span>
                <span style="padding: 0 4px; font-weight:700;">${den}</span>
            </div>
        `;
    }

    function calculate() {
        const w1 = parseInt(document.getElementById('w1').value) || 0;
        const n1 = parseInt(document.getElementById('n1').value) || 0;
        const d1 = parseInt(document.getElementById('d1').value) || 1;
        const w2 = parseInt(document.getElementById('w2').value) || 0;
        const n2 = parseInt(document.getElementById('n2').value) || 0;
        const d2 = parseInt(document.getElementById('d2').value) || 1;

        if (d1 === 0 || d2 === 0) { alert("エラー: 分母に0を入力することはできません。"); return; }
        const num1 = (w1 * d1) + n1;
        const num2 = (w2 * d2) + n2;
        if (num2 === 0) { alert("エラー: 0で割ることはできません。"); return; }

        const resN = num1 * d2;
        const resD = d1 * num2;
        const [sN, sD] = simplify(resN, resD);

        // Visualizer Update
        const visArea = document.getElementById('visualizer-area');
        if (visArea) {
            visArea.style.display = 'block';
            document.getElementById('bar-a').style.width = `${Math.min(100, (num1/d1) * 30)}%`;
            document.getElementById('bar-b').style.width = `${Math.min(100, (num2/d2) * 30)}%`;
        }

        let steps = [];
        if (w1 !== 0 || w2 !== 0) {
            steps.push({ label: "帯分数を仮分数に直す", math: `${formatFractionHtml(num1, d1)} ÷ ${formatFractionHtml(num2, d2)}` });
        }
        steps.push({ label: "わる数をひっくり返して かけ算にする（逆数）", math: `${formatFractionHtml(num1, d1)} × ${formatFractionHtml(d2, num2)}` });
        steps.push({ label: "そのまま計算する", math: `${formatFractionHtml(num1 * d2, d1 * num2)}` });
        if (resD !== sD) steps.push({ label: "約分する", math: `${formatFractionHtml(sN, sD)}` });

        // Final result with mixed number version
        let finalHtml = formatFractionHtml(sN, sD);
        if (sD !== 1 && sN > sD) {
            const whole = Math.floor(sN / sD);
            const rem = sN % sD;
            finalHtml += ` <span style="font-size: 1.5rem; margin: 0 0.5rem;">=</span> ${whole} ${formatFractionHtml(rem, sD)}`;
        }

        renderResult(steps, finalHtml);
        saveHistory(`${w1?w1+' ':''}${n1}/${d1} ÷ ${w2?w2+' ':''}${n2}/${d2} = ${sN}/${sD}`);
    }

    function renderResult(steps, final) {
        resultSteps.innerHTML = '';
        steps.forEach(step => {
            const card = document.createElement('div');
            card.className = 'step-card';
            card.innerHTML = `<div class="step-label">${step.label}</div><div class="step-content">${step.math}</div>`;
            resultSteps.appendChild(card);
        });
        finalResult.innerHTML = final;
        resultSection.style.display = 'block';
        resultSection.scrollIntoView({ behavior: 'smooth' });
    }

    function saveHistory(equation) {
        history.unshift(equation);
        if (history.length > 5) history.pop();
        localStorage.setItem('fracHistory', JSON.stringify(history));
    }

    function updateHistoryUI() {
        if (!historySection) return;
        historyList.innerHTML = '';
        history.forEach(item => {
            const div = document.createElement('div');
            div.className = 'history-item';
            div.innerText = item;
            historyList.appendChild(div);
        });
    }

    function generateQuiz() {
        let n1, d1, n2, d2, w1 = 0, w2 = 0;

        if (currentLevel === 'easy') {
            n1 = Math.floor(Math.random() * 4) + 1;
            d1 = Math.floor(Math.random() * 4) + 2;
            n2 = Math.floor(Math.random() * 4) + 1;
            d2 = Math.floor(Math.random() * 4) + 2;
        } else if (currentLevel === 'medium') {
            n1 = Math.floor(Math.random() * 8) + 1;
            d1 = Math.floor(Math.random() * 10) + 2;
            n2 = Math.floor(Math.random() * 8) + 1;
            d2 = Math.floor(Math.random() * 10) + 2;
        } else { // Hard (mixed numbers)
            w1 = Math.floor(Math.random() * 3) + 1;
            n1 = Math.floor(Math.random() * 5) + 1;
            d1 = Math.floor(Math.random() * 5) + 2;
            w2 = Math.floor(Math.random() * 2) + 1;
            n2 = Math.floor(Math.random() * 5) + 1;
            d2 = Math.floor(Math.random() * 5) + 2;
        }

        const totalN1 = (w1 * d1) + n1;
        const totalN2 = (w2 * d2) + n2;
        currentQuizAnswer = simplify(totalN1 * d2, d1 * totalN2);

        quizProblem.innerText = `${w1?w1+' ':''}${n1}/${d1} ÷ ${w2?w2+' ':''}${n2}/${d2} = ?`;
        quizAnsN.value = '';
        quizAnsD.value = '';
        quizFeedback.innerText = '';
        nextQuizBtn.style.display = 'none';
        quizFeedback.style.color = 'inherit';
    }

    function checkQuiz() {
        const uN = parseInt(quizAnsN.value);
        const uD = parseInt(quizAnsD.value) || 1;
        
        if (uN === currentQuizAnswer[0] && uD === currentQuizAnswer[1]) {
            quizFeedback.innerText = "🎉 正解です！完璧にマスターしています。";
            quizFeedback.style.color = 'var(--secondary)';
            nextQuizBtn.style.display = 'inline-block';
        } else {
            quizFeedback.innerText = "❌ 惜しい！約分が正しいか確認してください。正解は " + currentQuizAnswer[0]+"/"+currentQuizAnswer[1] + " でした。";
            quizFeedback.style.color = 'var(--danger)';
            nextQuizBtn.style.display = 'inline-block';
        }
    }

    function toggleTheme() {
        document.body.classList.toggle('dark-mode');
        localStorage.setItem('fracTheme', document.body.classList.contains('dark-mode') ? 'dark' : 'light');
    }

    function resetCalculator() {
        document.querySelectorAll('input').forEach(i => i.value = '');
        resultSection.style.display = 'none';
        const visArea = document.getElementById('visualizer-area');
        if (visArea) visArea.style.display = 'none';
    }

    function copyResult() {
        const text = finalResult.innerText;
        navigator.clipboard.writeText(text).then(() => alert("結果をコピーしました！"));
    }
});
