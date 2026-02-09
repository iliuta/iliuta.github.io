---
layout: default
title: RowerTrain
lang: en
---

<link rel="alternate" hreflang="fr" href="https://iliuta.github.io/fr/" />
<link rel="alternate" hreflang="de" href="https://iliuta.github.io/de/" />
<link rel="alternate" hreflang="en" href="https://iliuta.github.io/" />

<script>
  // Detect browser language and redirect to French or German version if applicable
  var userLang = navigator.language || navigator.userLanguage;
  if (window.location.pathname === '/') {
    if (userLang.startsWith('fr')) {
      window.location.href = '/fr/';
    } else if (userLang.startsWith('de')) {
      window.location.href = '/de/';
    }
  }
</script>

<div style="text-align: right; margin-bottom: 20px;">
  <strong>Language / Langue / Sprache:</strong>
  <a href="/">English</a> | <a href="/fr/">Français</a> | <a href="/de/">Deutsch</a>
</div>

{% include_relative README.md %}
