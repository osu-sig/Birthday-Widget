---
title: Birthday
description: A dashing widget to remind you of birthdays
author: Michael Woffendin
tags: dashing, widget, status, service, uptime
created:  2015 Jan 12
modified: 2015 Jan 12

---

Fancy List
=========

![alt tag](https://raw.github.com/osu-sig/Birthday-Widget/master/screenshot.png)

## What is it?

The Birthday widget is great for small offices to remember coworkers' birthdays. It has a countdown clock before the person's birthday, and an eye-catching transforming color effect on the person's birthday.

## What's the best way to use it?

Included is an example Model which retrieves upcoming birthdays from a YAML file. You can feel free to reuse this for your own purposes. It also has an rspec file if you like tests.

Since birthdays aren't usually a weekly occurrence, it may be a good idea to hide / show the birthday tile only if there's a nearby birthday.

## What if I don't like the color-changing effect?

You can disable the color-changing effect by setting the 'lame' html attribute to true on your dashboard's birthday tile. Eg "lame=true"

## Are there any dependencies?

If you want the cake image, then you will need FontAwesome CSS and fonts. You can get them here: http://fortawesome.github.io/Font-Awesome/ (it really is awesome!)

If you want to use the model and spec file, you'll need the base class and spec helper from our other repo: URL-GOES-HERE

