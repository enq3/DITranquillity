# Позднее связывание
Использование модулей, не является чем-то обязательным. Даже более для мелких проектов это будет злом, нежели добром. Модули были придуманы, чтобы решать две проблемы:
* Коллизии имен. Если у вас большой приложение, рано или поздно появятся классы с одним названием, но в разных подроектах.
* Позднее связывание.

Позднее связывание, слегка надуманная проблема - если бы все имена хранились в одном контейнере, что является правдой если вы не используете модули, то это было бы не нужно. Но если проект большой, то рано или поздно начнутся коллизии имен, а значит, придется ограничивать область видимости, из-за чего придется выделять интерфейсы в отдельные модули.

В принципе позднее связывание доступно, только если используются модули.

## Объявление
Объявление типа, реализация которого будет объявлена в каком-нибудь другом модуле, делается с помощью функции `register(protocol:)`:
```Swift
builder.register(protocol: YourProtocol.self)
```

!! Обращаю внимание, что при регистрации протокола не добавляются никакие модификаторы. Модификаторы указываются при указании реализации

## Объявление реализации
На самом деле чтобы объявить реализацию не нужно использовать какой-то особый синтаксис. Реализация автоматически найдется, если у типа в качестве альтернативного был указан протокол:
```Swift
builder.register(type: YourProtocolImpl.self)
  .as(YourProtocol.self).check{$0}
  ...
```

## На что стоит обратить внимание
В отличие от обычных типов, все модули которые знаю о протоколе, знают и о реализации, но только под именем протокола, даже если эта реализация скрыта. Но надо понимать, что регистрация реализации должна тоже попасть в конечный контейнер иначе библиотека не сможет догадаться о её существовании.

Если тип использует позднее связывание, то рекомендуется использовать опциональное получение объекта, так-как реализации может и не оказаться.

## Ошибки
Так как использование модулей, добавляет область видимости для типов, то это значит, что возможно попытаться обратится к объекту, к которому нет доступа. Для таких случаев предусмотрена специальная ошибка:
> Ошибка: **`DIError.noAccess(typesInfo:, accessModules:)`**
> Параметры: typesInfo - информация обо всех регистрациях некоторого типа
>            accessModules - модули, из которых есть доступ к типу
***

#### [Главная](main.md)
#### [Предыдущая глава "Модули"](module.md#Модули)
#### [Следующая глава "Storyboard"](storyboard.md#storyboard)
