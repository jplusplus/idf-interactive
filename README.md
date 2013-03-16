# Ile-de-France Interactive 
## Installation
### Software dependencies
To make this project up and running, you need:

* **Node** 0.8.7
* **NPM** 1.1.32


### Dependencies
This project is build at the top of the pleasant [Node Package Manager](http://npmjs.org/). To download and set up the whole dependancies three, simply run from the project's root directory :

    $ npm install

### Environment variables
The following environment variables can be use with the highest priority :

* **PORT** defines the port to listen to (ex: *80*);
* **NODE_ENV** defines the runing mode (ex: *development*, *production*, etc);

## Run
To launch the server (once the installation is complete), just run from the root of the project:

```
$ node app.js
```

## Create a page
### Create a JSON file
To exist, every page must have a corresponding JSON file in the ```/data``` directory. For instance, the */exemple.html* is related to the file ```/data/exemple.json```.

### JSON file structure
Such as a configuration file, the JSON file must fit to the following structure :

```javascript
// An array detailing every steps
[
    // Step configuration
    {        
        "name": "name of the step",
        "spots": [ 
            // Spot configuration
            {
                "top":  "0%",
                "left": "50%",
                // ...
            }
        ],
        // ...
    }
]
```
# Ile-de-France Interactive 
## Installation
### Software dependencies
To make this project up and running, you need:

* **Node** 0.8.7
* **NPM** 1.1.32


### Dependencies
This project is build at the top of the pleasant [Node Package Manager](http://npmjs.org/). To download and set up the whole dependancies three, simply run from the project's root directory :

    $ npm install

### Environment variables
The following environment variables can be use with the highest priority :

* **PORT** defines the port to listen to (ex: *80*);
* **NODE_ENV** defines the runing mode (ex: *development*, *production*, etc);

## Run
To launch the server (once the installation is complete), just run from the root of the project:

```
$ node app.js
```

## Create a page
### Create a JSON file
To exist, every page must have a corresponding JSON file in the ```/data``` directory. For instance, the */exemple.html* is related to the file ```/data/exemple.json```.

### JSON file structure
Such as a configuration file, the JSON file must fit to the following structure :

```javascript
// An array detailing every steps
[
    // Step configuration
    {        
        "name": "name of the step",
        "spots": [ 
            // Spot configuration
            {
                "top":  "0%",
                "left": "50%",
                // ...
            }
        ],
        // ...
    }
]
```
<a name="steps"/>
### Step configuration
Every step object can follow this options:

Name | Type | Description | Exemple |
---- | ---- | ---- | ---- |
name | String | Name of the step, displaying on the main menu. | "Soft kitty, warm kitty"
no-index | Boolean | Set to true exit the step from the main menu. |
picture | String | URL to an image file to display as "background", take the whole width. | 
style | String | Inline CSS to apply to the current step. | "font-size:17px; color: red"
spots | Array | List of spots display in that step, see also [Spot configuration](#spots). |
class | String | One or serveral space-separated classes to put on the step | "purr"

<a name="spots"/>
### Spot configuration
Every spot object can follow this options:

Name | Type | Description | Exemple |
---- | ---- | ---- | ---- |
top | String | Top position of the spot from the top-left corner of the step. | "10%"
left | String | Left position of the spot from the top-left corner of the step. | "20%"
width | String | Width of the spot. | "100px"
height | String | Height of the spot. Take the width value by default. | "auto"
title | String | Title of the spot, display at its head. | "Little ball of fur"
sub-title | String  | Sub-title of the spot, display bellow the title. | "Happy kitty, sleepy kitty"
picture | Object | A picture to dispay bellow the sub-title. Taken to properties: ```src```and ```alt``` |
style | String | Inline CSS to apply to the current spot. | "font-size:17px; color: red"
class | String | One or serveral space-separated classes to put on the spot. | "purr"
entrance | String | Animates the entrance of the spot when a step the get the focus. See also [#entrances](Entrance animation) | "zoomIn", "left", etc
queue | Boolean | If true, the spot wait the end of the previous spot's entrance to appear. |
background | String | URL to an image file to display as background of the step |
background-direction | String, Number | Animate the background into that direction in a loop. Can be a number to specify a dicrection in degree. | "left", 90, "top left", etc
background-speed | Number | Distance in pixels to run through at each animation step. 3 by default. | 10


<a name="entrances"/>
### Entrance animations
To animate the entrance of a spot, you can use one or several of the following animation class :

Name | Description
---- | ----
left | Sliding to the left with fading
right | Sliding to the right with fading
up | Sliding to the top with fading
down | Sliding to the bottom with fading
zoomIn | Zoom in (getting bigger) with fading
zoomOut | Zoom out (getting smaller) with fading
fadeIn | Fading entrance

## MIT License

Copyright (c) 2013 Journalism++ SAS - Paris, France 

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## MIT License

Copyright (c) 2013 Journalism++ SAS - Paris, France 

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
