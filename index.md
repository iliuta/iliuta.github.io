---
layout: default
title: RowerTrain
lang: en
description: RowerTrain is a Bluetooth FTMS rowing app for indoor rowing training, structured workouts, heart-rate tracking, Strava, and virtual routes.
---

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
