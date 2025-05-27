/*
 * This file is part of Granola VST.
 * Copyright (C) 2025 Bespoke Samples
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */


Content.makeFrontInterface(400, 400);

Engine.loadFontAs("{PROJECT_FOLDER}Fonts/Inter/InterBold.ttf", "InterBold");
Engine.loadFontAs("{PROJECT_FOLDER}Fonts/Inter/InterItalic.ttf", "InterItalic");
Engine.loadFontAs("{PROJECT_FOLDER}Fonts/Inter/InterRegular.ttf", "Inter");
Engine.loadFontAs("{PROJECT_FOLDER}Fonts/Jersey20/Jersey10.ttf", "Jersey20");
Engine.loadFontAs("{PROJECT_FOLDER}Fonts/icons.ttf", "Icons");


const var background = Content.getComponent("background");


background.loadImage("{PROJECT_FOLDER}background.jpg", "background");
background.setPaintRoutine(function(g) {
	var a = this.getLocalBounds(0);
	g.drawImage("background", a, 0, 0);  // Draw the background image

    g.setColour(Colours.withAlpha(0xffC9CFD6, 0.85));
    g.fillRect([0, 200, 400, 200]);

    g.setColour(Colours.white);

    g.setFont("Icons", 26);
    g.drawAlignedText("a", [13,11, 30, 30], "left");

    g.setFont("Jersey20", 30);
    g.drawAlignedText("granola", [48,7, 88, 30], "left");

    g.setFont("InterBold", 16);
    g.drawAlignedText("bespoke", [275, 13, 68, 19], "left");
    g.setFont("Inter", 16);
    g.drawAlignedText("samples", [333, 13, 63, 19], "left");

    g.setColour(0xff313131);
    g.drawLine(275, 275, 227, 373, 1);
});

//small knob laf
const var smallKnobLaf = Content.createLocalLookAndFeel();

smallKnobLaf.registerFunction("drawRotarySlider", function(g, obj)
{
	var K = Content.createPath();
    var p1 = Content.createPath();
    var range = obj.max - obj.min;
    var startOffset = 2.45;
    var arcThickness = 0.1;
    var arcWidth = 1.0 - 2.0 * arcThickness;

    p1.clear();

	var endOffset = -startOffset + 2.0 * startOffset * obj.valueNormalized;

    var val = "";

    //change conWidth to change visible width of knob
    var conWidth = 39;

    var a = obj.area;
    var w = obj.area;
    var round = 2;
    var h = a[3];

    p1.addArc([arcThickness / 2, arcThickness / 2, arcWidth + arcThickness, arcWidth + arcThickness], - startOffset , 2.5);

    var pathArea = p1.getBounds(conWidth);

    //dark color
    g.setColour(obj.itemColour2);

    //draw background path
    g.drawPath(p1, pathArea, conWidth * arcThickness);

    K.addArc([arcThickness / 2, arcThickness / 2, arcWidth + arcThickness, arcWidth + arcThickness], -startOffset - 0.08 , endOffset);

    var pathArea = K.getBounds(conWidth);

	//light color
    g.setColour(obj.itemColour1);

    //draw indicator path
    g.drawPath(K, pathArea, conWidth * arcThickness);
});

const var position = Content.getComponent("position");
const var size = Content.getComponent("size");
const var interval = Content.getComponent("interval");
const var pitch = Content.getComponent("pitch");
const var width = Content.getComponent("width");
const var mix = Content.getComponent("mix");
const var gain = Content.getComponent("gain");

position.setLocalLookAndFeel(smallKnobLaf);
size.setLocalLookAndFeel(smallKnobLaf);
interval.setLocalLookAndFeel(smallKnobLaf);
pitch.setLocalLookAndFeel(smallKnobLaf);
width.setLocalLookAndFeel(smallKnobLaf);
mix.setLocalLookAndFeel(smallKnobLaf);
gain.setLocalLookAndFeel(smallKnobLaf);



// label showing values (thanks to @HISEnberg)
const var UiKnobs = [
                     Content.getComponent("position"),
                     Content.getComponent("size"),
                     Content.getComponent("interval"),
                     Content.getComponent("pitch"),
                     Content.getComponent("width"),
                     Content.getComponent("mix"),
                     Content.getComponent("gain")];

const var UiLabels = [Content.getComponent("positionLabel"),
                      Content.getComponent("sizeLabel"),
                      Content.getComponent("intervalLabel"),
                      Content.getComponent("pitchLabel"),
                      Content.getComponent("widthLabel"),
                      Content.getComponent("mixLabel"),
                      Content.getComponent("gainLabel")];

const var UiSuffixes = ["ms", "ms", "ms", "st", "%", "%", "dB"];

for (i = 0; i < UiLabels.length; i++)
{
	UiLabels[i].set("editable", false);
	UiLabels[i].set("enabled", true);
	UiLabels[i].set("textColour", 0xFF252424);
}

const var LabelBroadcaster = Engine.createBroadcaster({
  "id": "Knob Labels",
  "args": ["component", "event"]
});




// Attach the broadcaster to component mouse events
LabelBroadcaster.attachToComponentMouseEvents(UiKnobs, "All Callbacks", "Knob & Label Mouse Listener");

// Listener for the broadcaster
LabelBroadcaster.addListener("LabelListener", "Set labels to display knob values", function(component, event)
{
    if (event.drag || event.hover)
    {
        for (i = 0; i < UiKnobs.length; i++)
        {
            if (UiKnobs[i] == component)
            {
                reg knobSuffix = UiKnobs[i].get("suffix");
                reg valueChange = Engine.doubleToString(component.getValue(), 0) + UiSuffixes[i]; // The number indicates how many decimal points
                UiLabels[i].set("text", valueChange);
                break;
            }
        }
    }
    else
    {
        for (i = 0; i < UiKnobs.length; i++)
        {
            UiLabels[i].set("text", UiKnobs[i].get("text"));
        }
    }
});

// Initialize the labels with the knobs' names
for (i = 0; i < UiLabels.length; i++)
{
    UiLabels[i].set("text", UiKnobs[i].get("text"));
}
function onNoteOn()
{

}
 function onNoteOff()
{

}
 function onController()
{

}
 function onTimer()
{

}
 function onControl(number, value)
{

}
