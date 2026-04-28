$ErrorActionPreference = "Stop"

$baseUrl = "https://xn--u9jwc214lnma979ejm4a.com"
$siteName = "&#20998;&#25968;&#12398;&#21106;&#12426;&#31639;.com"
$siteNamePlain = [System.Net.WebUtility]::HtmlDecode($siteName)
$lastMod = "2026-04-27"

$pageRows = Get-Content -Path "pages-data.txt" -Encoding UTF8 | ConvertFrom-Json
$problemRows = Get-Content -Path "problems-data.txt" -Encoding UTF8 | ConvertFrom-Json

function Decode-Entities {
    param([string]$text)
    return [System.Net.WebUtility]::HtmlDecode($text)
}

$navHome = "&#12507;&#12540;&#12512;"
$navMain = "&#20998;&#25968;&#12398;&#21106;&#12426;&#31639;"
$navCalc = "&#20998;&#25968;&#12398;&#35336;&#31639;"
$navWhat = "&#20998;&#25968;&#12392;&#12399;"
$navSimple = "&#20998;&#25968;&#12398;&#32004;&#20998;"
$labelBasic = "&#22522;&#26412;"
$labelExample = "&#25163;&#38918;&#12388;&#12365;&#12398;&#20363;&#38988;"
$labelMistakes = "&#12424;&#12367;&#12354;&#12427;&#38291;&#36949;&#12356;"
$labelTips = "&#12377;&#12368;&#20351;&#12360;&#12427;&#12467;&#12484;"
$labelFaq = "&#12424;&#12367;&#12354;&#12427;&#36074;&#21839;"
$labelNext = "&#27425;&#12395;&#12420;&#12427;&#12371;&#12392;"
$labelPoint = "&#22823;&#20107;&#12394;&#12493;&#12452;&#12531;&#12488;"
$labelRelated = "&#38306;&#36899;&#12506;&#12540;&#12472;"
$labelOverview = "&#12371;&#12398;&#12506;&#12540;&#12472;&#12391;&#12431;&#12363;&#12427;&#12371;&#12392;"
$labelGuide = "&#35299;&#12365;&#26041;&#12398;&#27969;&#12428;"
$labelFaqLead = "&#12388;&#12414;&#12378;&#12365;&#12420;&#12377;&#12356;&#28857;&#12418;&#21547;&#12417;&#12390;&#30701;&#12367;&#12414;&#12392;&#12417;&#12414;&#12375;&#12383;&#12290;"
$labelPracticeLead = "&#12420;&#12426;&#26041;&#12434;&#35211;&#12383;&#12354;&#12392;&#12399;&#12289;&#31777;&#21336;&#12394;&#20363;&#38988;&#12391;&#27969;&#12428;&#12434;&#30906;&#12363;&#12417;&#12427;&#12398;&#12364;&#12362;&#12377;&#12377;&#12417;&#12391;&#12377;&#12290;"
$labelSemanticNav = "&#12467;&#12531;&#12486;&#12531;&#12484;&#12490;&#12499;&#12466;&#12540;&#12471;&#12519;&#12531;"
$ctaTop = "&#20998;&#25968;&#12398;&#21106;&#12426;&#31639;&#12488;&#12483;&#12503;&#12408;"
$ctaPractice = "&#32244;&#32722;&#21839;&#38988;&#12434;&#35211;&#12427;"

function To-JsonLd {
    param($Object)
    return ($Object | ConvertTo-Json -Depth 10 -Compress)
}

function Get-AssetPath {
    param([string]$slug, [string]$fileName)
    if ($slug -like "/problems/*") {
        return "../$fileName"
    }
    return $fileName
}

function Get-ExampleHtml {
    return "<p><strong>&#21839;&#38988;:</strong> 1/2 &#247; 3/4</p><p><strong>Step 1:</strong> 3/4 &#12434;&#36870;&#25968;&#12398; 4/3 &#12395;&#12375;&#12414;&#12377;&#12290;</p><p><strong>Step 2:</strong> 1/2 &#215; 4/3 &#12395;&#30452;&#12375;&#12414;&#12377;&#12290;</p><p><strong>Step 3:</strong> &#20998;&#23376;&#12392;&#20998;&#27597;&#12434;&#25499;&#12369;&#12390; 4/6 &#12395;&#12375;&#12414;&#12377;&#12290;</p><p><strong>Step 4:</strong> 4/6 &#12434;&#32004;&#20998;&#12375;&#12390; 2/3 &#12395;&#12375;&#12414;&#12377;&#12290;</p><p><strong>&#31572;&#12360;:</strong> 2/3</p>"
}

function Get-BreadcrumbJson {
    param(
        [string]$name,
        [string]$canonical
    )

    return @{
        "@context" = "https://schema.org"
        "@type" = "BreadcrumbList"
        itemListElement = @(
            @{
                "@type" = "ListItem"
                position = 1
                name = Decode-Entities $navHome
                item = "$baseUrl/"
            },
            @{
                "@type" = "ListItem"
                position = 2
                name = $name
                item = $canonical
            }
        )
    }
}

function Get-PageFaqItems {
    param($page)

    return @(
        @{
            q = "$($page.keyword)" + (Decode-Entities "&#12391;&#12399;&#20309;&#12434;&#35226;&#12360;&#12428;&#12400;&#12424;&#12356;&#12391;&#12377;&#12363;&#65311;")
            a = Decode-Entities "&#12356;&#12385;&#12400;&#12435;&#22823;&#20107;&#12394;&#12398;&#12399;&#12289;&#21106;&#12427;&#25968;&#12434;&#36870;&#25968;&#12395;&#12375;&#12390;&#25499;&#12369;&#31639;&#12408;&#30452;&#12377;&#27969;&#12428;&#12391;&#12377;&#12290;&#26368;&#24460;&#12395;&#32004;&#20998;&#12414;&#12391;&#30906;&#35469;&#12377;&#12427;&#12392;&#31572;&#12360;&#12364;&#25972;&#12356;&#12414;&#12377;&#12290;"
        },
        @{
            q = Decode-Entities "&#12394;&#12380;&#36870;&#25968;&#12434;&#20351;&#12358;&#12398;&#12391;&#12377;&#12363;&#65311;"
            a = Decode-Entities "&#20998;&#25968;&#12398;&#21106;&#12426;&#31639;&#12434;&#25499;&#12369;&#31639;&#12398;&#24418;&#12395;&#30452;&#12377;&#12392;&#12289;&#20998;&#23376;&#12393;&#12358;&#12375;&#12392;&#20998;&#27597;&#12393;&#12358;&#12375;&#12391;&#35336;&#31639;&#12375;&#12420;&#12377;&#12367;&#12394;&#12427;&#12363;&#12425;&#12391;&#12377;&#12290;"
        },
        @{
            q = Decode-Entities "&#12393;&#12371;&#12391;&#31572;&#12360;&#21512;&#12431;&#12379;&#12391;&#12365;&#12414;&#12377;&#12363;&#65311;"
            a = Decode-Entities "&#12488;&#12483;&#12503;&#12506;&#12540;&#12472;&#12398;&#20998;&#25968;&#12398;&#21106;&#12426;&#31639;&#12398;&#35336;&#31639;&#27231;&#12391;&#12289;&#36884;&#20013;&#24335;&#12388;&#12365;&#12398;&#30906;&#35469;&#12364;&#12391;&#12365;&#12414;&#12377;&#12290;"
        }
    )
}

function Get-SoftwareSchema {
    param($page, [string]$canonical)

    if ($page.slug -notin @("/fraction-division-calculator", "/fraction-auto-calc", "/score-calculator")) {
        return $null
    }

    return @{
        "@context" = "https://schema.org"
        "@type" = "SoftwareApplication"
        name = $page.title
        applicationCategory = "EducationalApplication"
        operatingSystem = "Web"
        inLanguage = "ja"
        description = $page.description
        url = $canonical
        offers = @{
            "@type" = "Offer"
            price = "0"
            priceCurrency = "JPY"
        }
    }
}

function Get-PageHtml {
    param($page)

    $canonical = "$baseUrl$($page.slug)"
    $styleHref = Get-AssetPath -slug $page.slug -fileName "styles.css"
    $exampleHtml = Get-ExampleHtml
    $faqItems = Get-PageFaqItems -page $page
    $faqHtml = (($faqItems | ForEach-Object {
        "<details class=""faq-item""><summary>$([System.Net.WebUtility]::HtmlEncode($_.q))</summary><p>$([System.Net.WebUtility]::HtmlEncode($_.a))</p></details>"
    }) -join "`n          ")
    $faqSchemaEntities = @()
    foreach ($faq in $faqItems) {
        $faqSchemaEntities += @{
            "@type" = "Question"
            name = $faq.q
            acceptedAnswer = @{
                "@type" = "Answer"
                text = $faq.a
            }
        }
    }

    $articleSchema = To-JsonLd @{
        "@context" = "https://schema.org"
        "@type" = "Article"
        headline = $page.title
        description = $page.description
        inLanguage = "ja"
        dateModified = $lastMod
        mainEntityOfPage = $canonical
        author = @{
            "@type" = "Organization"
            name = $siteNamePlain
        }
        publisher = @{
            "@type" = "Organization"
            name = $siteNamePlain
        }
    }

    $faqSchema = To-JsonLd @{
        "@context" = "https://schema.org"
        "@type" = "FAQPage"
        mainEntity = $faqSchemaEntities
    }

    $breadcrumbSchema = To-JsonLd (Get-BreadcrumbJson -name $page.keyword -canonical $canonical)
    $softwareSchema = Get-SoftwareSchema -page $page -canonical $canonical
    $softwareSchemaHtml = ""
    if ($null -ne $softwareSchema) {
        $softwareSchemaHtml = "<script type=""application/ld+json"">$(To-JsonLd $softwareSchema)</script>"
    }

@"
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>$($page.title) - $siteName</title>
  <meta name="description" content="$($page.description)">
  <meta name="robots" content="index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1">
  <meta name="theme-color" content="#2563eb">
  <link rel="canonical" href="$canonical">
  <link rel="stylesheet" href="$styleHref">
  <meta property="og:title" content="$($page.title) - $siteName">
  <meta property="og:description" content="$($page.description)">
  <meta property="og:type" content="article">
  <meta property="og:url" content="$canonical">
  <meta property="og:site_name" content="$siteName">
  <meta property="og:locale" content="ja_JP">
  <meta name="twitter:card" content="summary">
  <meta name="twitter:title" content="$($page.title) - $siteName">
  <meta name="twitter:description" content="$($page.description)">
  <script type="application/ld+json">$articleSchema</script>
  <script type="application/ld+json">$breadcrumbSchema</script>
  <script type="application/ld+json">$faqSchema</script>
  $softwareSchemaHtml
</head>
<body>
  <header>
    <a href="/" class="brand" aria-label="$siteName">
      <div class="brand-icon">&#247;</div>
      <span class="brand-name">$siteName</span>
    </a>
    <nav class="desktop-nav">
      <a href="/">$navMain</a>
      <a href="/fraction-calculation">$navCalc</a>
      <a href="/what-is-fraction">$navWhat</a>
      <a href="/fraction-simplifier">$navSimple</a>
    </nav>
  </header>
  <main class="content-page">
    <nav class="breadcrumb">
      <a href="/">$navHome</a><span>/</span><span>$($page.keyword)</span>
    </nav>
    <section class="hero page-hero">
      <p class="eyebrow">$($page.keyword)</p>
      <h1>$($page.title)</h1>
      <p>$($page.intro)</p>
    </section>
    <div class="page-shell">
      <aside class="article-nav" aria-label="$labelSemanticNav">
        <div class="article-nav-card">
          <p class="article-nav-title">$labelOverview</p>
          <a href="#overview">$labelBasic</a>
          <a href="#guide">$labelGuide</a>
          <a href="#example">$labelExample</a>
          <a href="#mistakes">$labelMistakes</a>
          <a href="#tips">$labelTips</a>
          <a href="#faq">$labelFaq</a>
        </div>
      </aside>
      <article class="seo-article">
        <section class="calculator-card content-block" id="overview">
          <h2 class="section-title">$labelBasic</h2>
          <p class="section-intro">$($page.lead)</p>
          <div class="grid-2 compact-grid">
            <article class="info-card">
              <h3>$labelOverview</h3>
              <p>$($page.intro)</p>
            </article>
            <article class="info-card">
              <h3>$labelPoint</h3>
              <p>$($page.reason)</p>
            </article>
          </div>
        </section>
        <section class="calculator-card content-block" id="guide">
          <h2 class="section-title">$labelGuide</h2>
          <p class="section-intro">&#20998;&#25968;&#12398;&#21106;&#12426;&#31639;&#12398;&#22522;&#26412;&#12399;&#12289;&#21106;&#12427;&#25968;&#12434;&#36870;&#25968;&#12395;&#12375;&#12390;&#25499;&#12369;&#31639;&#12395;&#30452;&#12377;&#27969;&#12428;&#12391;&#12377;&#12290;</p>
          <div class="howto-steps">
            <article class="step-summary"><h3>Step 1</h3><p>&#24335;&#12398;&#20013;&#12391;&#12289;&#12393;&#12398;&#25968;&#12434;&#21106;&#12427;&#12398;&#12363;&#12434;&#30906;&#35469;&#12375;&#12414;&#12377;&#12290;</p></article>
            <article class="step-summary"><h3>Step 2</h3><p>&#24460;&#12429;&#12398;&#25968;&#12384;&#12369;&#12434;&#36870;&#25968;&#12395;&#12375;&#12289;&#21046;&#12426;&#31639;&#12434;&#25499;&#12369;&#31639;&#12395;&#30452;&#12375;&#12414;&#12377;&#12290;</p></article>
            <article class="step-summary"><h3>Step 3</h3><p>&#20998;&#23376;&#12392;&#20998;&#27597;&#12434;&#12381;&#12428;&#12382;&#12428;&#25499;&#12369;&#12390;&#35336;&#31639;&#12375;&#12414;&#12377;&#12290;</p></article>
            <article class="step-summary"><h3>Step 4</h3><p>&#26368;&#24460;&#12395;&#32004;&#20998;&#12375;&#12390;&#12289;&#12377;&#12387;&#12365;&#12426;&#12375;&#12383;&#24418;&#12395;&#12375;&#12414;&#12377;&#12290;</p></article>
          </div>
        </section>
        <section class="calculator-card content-block" id="example">
          <h2 class="section-title">$labelExample</h2>
          <p class="section-intro">$labelPracticeLead</p>
          <div class="info-card rich-text">
            $exampleHtml
          </div>
        </section>
        <section class="calculator-card content-block" id="mistakes">
          <h2 class="section-title">$labelMistakes</h2>
          <ul class="content-list">
            <li>&#12402;&#12387;&#12367;&#12426;&#36820;&#12377;&#12398;&#12399;&#24460;&#12429;&#12398;&#25968;&#12384;&#12369;&#12394;&#12398;&#12395;&#12289;&#21069;&#12398;&#25968;&#12414;&#12391;&#21453;&#36578;&#12373;&#12379;&#12390;&#12375;&#12414;&#12358;</li>
            <li>&#25499;&#12369;&#31639;&#12395;&#30452;&#12375;&#12383;&#12354;&#12392;&#12391;&#12289;&#32004;&#20998;&#12391;&#12365;&#12427;&#12363;&#30906;&#35469;&#12375;&#12394;&#12356;</li>
            <li>&#36884;&#20013;&#24335;&#12434;&#30465;&#30053;&#12375;&#12390;&#12289;&#12393;&#12371;&#12391;&#12414;&#12385;&#12364;&#12387;&#12383;&#12363;&#12431;&#12363;&#12425;&#12394;&#12367;&#12394;&#12427;</li>
            <li>&#24111;&#20998;&#25968;&#12420;&#25972;&#25968;&#12434;&#20998;&#25968;&#12398;&#24418;&#12395;&#12394;&#12362;&#12373;&#12378;&#12395;&#35336;&#31639;&#12375;&#12390;&#12375;&#12414;&#12358;</li>
          </ul>
        </section>
        <section class="calculator-card content-block" id="tips">
          <h2 class="section-title">$labelTips</h2>
          <ul class="content-list tip-list">
            <li>&#12300;&#24460;&#12429;&#12384;&#12369;&#36870;&#25968;&#12301;&#12392;&#22768;&#12395;&#20986;&#12375;&#12390;&#30906;&#35469;&#12377;&#12427;&#12392;&#12511;&#12473;&#12364;&#28187;&#12426;&#12414;&#12377;</li>
            <li>&#35336;&#31639;&#21069;&#12395;&#32004;&#20998;&#12391;&#12365;&#12427;&#12363;&#35211;&#12427;&#12392;&#31639;&#25968;&#12364;&#27005;&#12395;&#12394;&#12426;&#12414;&#12377;</li>
            <li>&#31572;&#12360;&#12364;&#20998;&#25968;&#12398;&#12414;&#12414;&#12391;&#12424;&#12356;&#12363;&#12289;&#24111;&#20998;&#25968;&#12395;&#12377;&#12427;&#12409;&#12365;&#12363;&#12418;&#30906;&#35469;&#12375;&#12414;&#12375;&#12423;&#12358;</li>
            <li>&#36855;&#12387;&#12383;&#12425;<a href="/">$navMain</a>&#12395;&#25147;&#12387;&#12390;&#35336;&#31639;&#27231;&#12391;&#31572;&#12360;&#21512;&#12431;&#12379;&#12377;&#12427;&#12398;&#12364;&#23433;&#24515;&#12391;&#12377;</li>
          </ul>
        </section>
        <section class="calculator-card content-block" id="faq">
          <h2 class="section-title">$labelFaq</h2>
          <p class="section-intro">$labelFaqLead</p>
          <div class="faq-list">
            $faqHtml
          </div>
        </section>
        <section class="calculator-card content-block">
          <h2 class="section-title">$labelRelated</h2>
          <div class="related-links">
            <a class="chip-link" href="/">$navMain</a>
            <a class="chip-link" href="/fraction-calculation">$navCalc</a>
            <a class="chip-link" href="/what-is-fraction">$navWhat</a>
            <a class="chip-link" href="/fraction-simplifier">$navSimple</a>
          </div>
        </section>
        <section class="calculator-card cta-card content-block">
          <h2 class="section-title">$labelNext</h2>
          <p class="section-intro">$($page.cta)</p>
          <div class="hero-links">
            <a href="/" class="chip-link">$ctaTop</a>
            <a href="/practice" class="chip-link">$ctaPractice</a>
          </div>
        </section>
      </article>
    </div>
  </main>
  <footer>
    <div class="footer-nav">
      <a href="/privacy-policy">&#12503;&#12521;&#12452;&#12496;&#12471;&#12540;&#12509;&#12522;&#12471;&#12540;</a>
      <a href="/terms">&#21033;&#29992;&#35215;&#32004;</a>
      <a href="/contact">&#12362;&#21839;&#12356;&#21512;&#12431;&#12379;</a>
    </div>
    <p>&copy; 2026 $siteName. &#12377;&#12409;&#12390;&#12398;&#23398;&#32722;&#32773;&#12434;&#24540;&#25588;&#12377;&#12427;&#31639;&#25968;&#23398;&#32722;&#12469;&#12452;&#12488;&#12290;</p>
  </footer>
</body>
</html>
"@
}

function Get-ProblemHtml {
    param($problem)

    $canonical = "$baseUrl$($problem.slug)"
    $styleHref = Get-AssetPath -slug $problem.slug -fileName "styles.css"
    $problemKeyword = ($problem.keyword -replace "Ã·", "&#247;")
    $problemKeywordPlain = [System.Net.WebUtility]::HtmlDecode($problemKeyword)
    $problemArticle = To-JsonLd @{
        "@context" = "https://schema.org"
        "@type" = "Article"
        headline = "$problemKeywordPlain " + (Decode-Entities "&#12398;&#35299;&#12365;&#26041;")
        description = "$problemKeywordPlain " + (Decode-Entities "&#12434;&#36884;&#20013;&#24335;&#12388;&#12365;&#12391;&#12420;&#12373;&#12375;&#12367;&#35299;&#35500;&#12375;&#12414;&#12377;&#12290;")
        inLanguage = "ja"
        dateModified = $lastMod
        mainEntityOfPage = $canonical
    }
    $problemBreadcrumb = To-JsonLd (Get-BreadcrumbJson -name $problemKeywordPlain -canonical $canonical)
    $problemFaq = To-JsonLd @{
        "@context" = "https://schema.org"
        "@type" = "FAQPage"
        mainEntity = @(
            @{
                "@type" = "Question"
                name = "$problemKeywordPlain " + (Decode-Entities "&#12399;&#12393;&#12358;&#35299;&#12365;&#12414;&#12377;&#12363;&#65311;")
                acceptedAnswer = @{
                    "@type" = "Answer"
                    text = Decode-Entities "&#24460;&#12429;&#12398;&#20998;&#25968;&#12434;&#36870;&#25968;&#12395;&#12375;&#12390;&#25499;&#12369;&#31639;&#12408;&#30452;&#12375;&#12289;&#26368;&#24460;&#12395;&#32004;&#20998;&#12375;&#12414;&#12377;&#12290;"
                }
            }
        )
    }

@"
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>$problemKeyword &#12398;&#35299;&#12365;&#26041; - $siteName</title>
  <meta name="description" content="$problemKeyword &#12434;&#36884;&#20013;&#24335;&#12388;&#12365;&#12391;&#12420;&#12373;&#12375;&#12367;&#35299;&#35500;&#12375;&#12414;&#12377;&#12290;">
  <meta name="robots" content="index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1">
  <meta name="theme-color" content="#2563eb">
  <link rel="canonical" href="$canonical">
  <link rel="stylesheet" href="$styleHref">
  <meta property="og:title" content="$problemKeyword &#12398;&#35299;&#12365;&#26041; - $siteName">
  <meta property="og:description" content="$problemKeyword &#12434;&#36884;&#20013;&#24335;&#12388;&#12365;&#12391;&#12420;&#12373;&#12375;&#12367;&#35299;&#35500;&#12375;&#12414;&#12377;&#12290;">
  <meta property="og:type" content="article">
  <meta property="og:url" content="$canonical">
  <meta property="og:site_name" content="$siteName">
  <meta property="og:locale" content="ja_JP">
  <meta name="twitter:card" content="summary">
  <meta name="twitter:title" content="$problemKeyword &#12398;&#35299;&#12365;&#26041; - $siteName">
  <meta name="twitter:description" content="$problemKeyword &#12434;&#36884;&#20013;&#24335;&#12388;&#12365;&#12391;&#12420;&#12373;&#12375;&#12367;&#35299;&#35500;&#12375;&#12414;&#12377;&#12290;">
  <script type="application/ld+json">$problemArticle</script>
  <script type="application/ld+json">$problemBreadcrumb</script>
  <script type="application/ld+json">$problemFaq</script>
</head>
<body>
  <header>
    <a href="/" class="brand" aria-label="$siteName">
      <div class="brand-icon">&#247;</div>
      <span class="brand-name">$siteName</span>
    </a>
  </header>
  <main class="content-page">
    <nav class="breadcrumb">
      <a href="/">$navHome</a><span>/</span><span>$problemKeyword</span>
    </nav>
    <section class="hero page-hero">
      <p class="eyebrow">&#20491;&#21029;&#21839;&#38988;&#12506;&#12540;&#12472;</p>
      <h1>$problemKeyword &#12398;&#35299;&#12365;&#26041;</h1>
      <p>$problemKeyword &#12399;&#12289;&#24460;&#12429;&#12398; $($problem.b) &#12434;&#36870;&#25968;&#12398; $($problem.c) &#12395;&#12375;&#12390;&#25499;&#12369;&#31639;&#12408;&#30452;&#12375;&#12414;&#12377;&#12290;</p>
    </section>
    <article class="seo-article problem-article">
      <section class="calculator-card content-block">
        <h2 class="section-title">$labelGuide</h2>
        <div class="howto-steps">
          <article class="step-summary"><h3>Step 1</h3><p>$($problem.b) &#12434; $($problem.c) &#12395;&#12375;&#12414;&#12377;&#12290;</p></article>
          <article class="step-summary"><h3>Step 2</h3><p>$($problem.a) &#215; $($problem.c) &#12395;&#30452;&#12375;&#12414;&#12377;&#12290;</p></article>
          <article class="step-summary"><h3>Step 3</h3><p>&#20998;&#23376;&#12392;&#20998;&#27597;&#12434;&#35336;&#31639;&#12375;&#12289;&#24517;&#35201;&#12394;&#12425;&#32004;&#20998;&#12375;&#12414;&#12377;&#12290;</p></article>
        </div>
        <div class="info-card rich-text">
          <p><strong>&#26368;&#32066;&#30340;&#12394;&#31572;&#12360;:</strong> $($problem.answer)</p>
          <p><strong>&#30701;&#12356;&#35500;&#26126;:</strong> &#21046;&#12426;&#31639;&#12434;&#25499;&#12369;&#31639;&#12395;&#30452;&#12377;&#12383;&#12417;&#12395;&#12289;&#24460;&#12429;&#12398;&#25968;&#12434;&#36870;&#25968;&#12395;&#12375;&#12414;&#12377;&#12290;</p>
        </div>
      </section>
      <section class="calculator-card content-block">
        <h2 class="section-title">$labelRelated</h2>
        <div class="related-links">
          <a class="chip-link" href="/">$navMain</a>
          <a class="chip-link" href="/fraction-calculation">$navCalc</a>
          <a class="chip-link" href="/fraction-simplifier">$navSimple</a>
        </div>
      </section>
    </article>
  </main>
</body>
</html>
"@
}

foreach ($page in $pageRows) {
    $html = Get-PageHtml -page $page
    Set-Content -Path $page.file -Value $html -Encoding UTF8
}

New-Item -ItemType Directory -Path "problems" -Force | Out-Null
foreach ($problem in $problemRows) {
    $html = Get-ProblemHtml -problem $problem
    Set-Content -Path $problem.file -Value $html -Encoding UTF8
}

$sitemap = @()
$sitemap += '<?xml version="1.0" encoding="UTF-8"?>'
$sitemap += '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
$sitemap += "  <url><loc>$baseUrl/</loc><lastmod>$lastMod</lastmod><changefreq>weekly</changefreq><priority>1.0</priority></url>"
foreach ($page in $pageRows) {
    $sitemap += "  <url><loc>$baseUrl$($page.slug)</loc><lastmod>$lastMod</lastmod><changefreq>weekly</changefreq><priority>0.9</priority></url>"
}
foreach ($problem in $problemRows) {
    $sitemap += "  <url><loc>$baseUrl$($problem.slug)</loc><lastmod>$lastMod</lastmod><changefreq>monthly</changefreq><priority>0.8</priority></url>"
}
$sitemap += '</urlset>'
Set-Content -Path "sitemap.xml" -Value ($sitemap -join "`n") -Encoding UTF8
