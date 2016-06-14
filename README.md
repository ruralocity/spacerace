# Space Race

A simple racing game, set in space! This is a personal learning project I put together while reading *[Learn Game Programming with Ruby](https://pragprog.com/book/msgpkids/learn-game-programming-with-ruby)* by Mark Sobkowicz.

## To install

Install the Ruby dependencies (gosu) using Bundler:

```
$ bundle
```

or you might have luck with `gem install gosu`.

## To play

```
$ ruby main.rb
```

Steer the ship with the left and right arrow keys. Dodge as many opponents as
you can before you run out of fuel! Catch fuel pellets to extend the game.

## Credits

- Art: <OpenGameArt.org>. Licensed CC0 1.0 Universal (CC0 1.0). Yeah, most of the artwork is also used in the "Sector Five" game from *Learn Game Programming with Ruby*, because I got lazy.
- Music: "[Thinking Tension C](http://freepd.com/Sci-Fi%20Sounds/Thinking%20Tension%20C)" by Kevin McLeod. Licensed CC0 1.0 Universal (CC0 1.0)

## Ideas for future game features

- Add **different types of competing ships**, with different graphics and attributes (image, size, speed, sound).
- Add a **sweet title screen**!
- Basics usability improvements like restarting the game after a crash.
- Add **levels that are progressively difficult**: Maybe the lane gets narrower as you go from level to level, faster/different ships come into play, etc.
- **Damage meter**: Maybe not explode instantly, but take damage. You could pull into a space pitstop to have your ship space repaired by space robots or something.
- **Physics**: Maybe bounce off of smaller ships with less damage, but at the risk of bouncing into larger ships with greater damage?
