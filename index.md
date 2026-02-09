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

{% include_relative en/index.md %}
