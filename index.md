---
layout: default
title: RowerTrain
lang: en
---

<link rel="alternate" hreflang="fr" href="https://iliuta.github.io/fr/" />
<link rel="alternate" hreflang="en" href="https://iliuta.github.io/" />

<script>
  // Detect browser language and redirect to French version if applicable
  var userLang = navigator.language || navigator.userLanguage;
  if (userLang.startsWith('fr') && window.location.pathname === '/') {
    window.location.href = '/fr/';
  }
</script>

{% include_relative README.md %}
