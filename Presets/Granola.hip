Processor 
Type SynthChain ID 	Granola Bypassed Gain 	      �?Balance 	        VoiceLimit 	      P@KillFadeTime 	      4@IconColour 0 packageName  BuildVersion �  EditorStates BodyShown 0 Visible 1 Solo 0 Folded 1  ChildProcessors  Processor Type MidiProcessorChain ID Midi Processor Bypassed EditorStates BodyShown 1 Visible 0 Solo 0  ChildProcessors  Processor Type ScriptProcessor ID Interface Bypassed Script �Content.makeFrontInterface(400, 400);

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
  EditorStates BodyShown 1 Visible 1 Solo 0 contentShown 1 onInitOpen 1  ChildProcessors   Content  Control type ScriptSlider id 
position value 	      y@ Control type ScriptSlider id size value 	      y@ Control type ScriptSlider id 
interval value 	     @@ Control type ScriptSlider id pitch value 	         Control type ScriptSlider id width value 	         Control type ScriptSlider id mix value 	      I@ Control type ScriptSlider id gain value 	         UIData  ContentProperties DeviceType 	Desktop Component type ScriptPanel id background x 	        y 	        width 	      y@height 	      y@bgColour 4294967295  Component 
type ScriptPanel id crop x 	        y 	     @P@width 	      y@height 	      Y@bgColour 
16777215 textColour 
16777215 itemColour2 0 itemColour 0 Component type ScriptFloatingTile id osc x 	        y 	        ContentType AudioAnalyser bgColour 
16777215 itemColour 4294967295 itemColour2 4294967295 textColour 0 Data F{
  "ProcessorId": "osc",
  "Index": 1,
  "FollowWorkspace": false
} width 	      y@height 	     @j@parentComponent crop  Component type ScriptSlider id 
position x 	      E@y 	     �m@itemColour 4289360598 bgColour 4289360598 itemColour2 4280624164 width 	      D@height 	      D@mouseSensitivity 	   @33�?min 	      $@max 	     @�@processorId grains parameterId 
grainPos stepSize 	      �?isPluginParameter 1  Component type ScriptSlider id size x 	     �^@y 	     �m@width 	      D@height 	      D@mouseSensitivity 	   @33�?itemColour2 4280624164 itemColour 4289360598 min 	      $@max 	     @�@processorId grains parameterId grainSize stepSize 	      �?isPluginParameter 1  Component type ScriptSlider id 
interval x 	     �h@y 	     �m@width 	      D@height 	      D@mouseSensitivity 	   @33�?itemColour2 4280624164 itemColour 4289360598 min 	      $@max 	     @�@processorId grains parameterId 
interval stepSize 	      �?isPluginParameter 1  Component type ScriptSlider id pitch x 	      S@y 	     �s@width 	      D@height 	      D@mouseSensitivity 	   @33�?itemColour2 4280624164 itemColour 4289360598 min 	      (�max 	      (@processorId grains parameterId pitch stepSize 	      �?isPluginParameter 1  Component type ScriptSlider id width x 	     @e@y 	     �s@width 	      D@height 	      D@mouseSensitivity 	   @33�?itemColour2 4280624164 itemColour 4289360598 max 	      Y@processorId grains parameterId width stepSize 	      �?isPluginParameter 1  Component type ScriptSlider id mix x 	     �s@y 	     �m@width 	      D@height 	      D@mouseSensitivity 	   @33�?itemColour2 4280624164 itemColour 4289360598 max 	      Y@processorId grains parameterId mix stepSize 	      �?isPluginParameter 1  Component type ScriptSlider id gain x 	     �s@y 	     �s@width 	      D@height 	      D@mouseSensitivity 	   @33�?itemColour2 4280624164 itemColour 4289360598 min 	      B�max 	      (@processorId grains parameterId gain stepSize 	      �?isPluginParameter 1  Component type ScriptLabel id positionLabel x 	      ;@y 	     �q@text 
position fontName Inter editable     itemColour2 4280624164 textColour 	$$%�    width 	     �Q@height 	      .@fontSize 	      (@ Component type ScriptLabel id sizeLabel x 	     �Z@y 	     �q@text size fontName Inter fontSize 	      (@editable     textColour 	$$%�    width 	     �Q@height 	      .@ Component type ScriptLabel id intervalLabel x 	      g@y 	     �q@text 
interval fontName Inter fontSize 	      (@editable     textColour 	$$%�    height 	      .@width 	     �Q@ Component type ScriptLabel id pitchLabel x 	      N@y 	     0v@fontName Inter fontSize 	      (@editable     textColour 	$$%�    height 	      .@text pitch width 	     �Q@ Component type ScriptLabel id widthLabel x 	     `c@y 	     0v@fontName Inter fontSize 	      (@editable     textColour 	$$%�    height 	      .@text width width 	     �Q@ Component type ScriptLabel id 
mixLabel x 	     �r@y 	     �q@fontName Inter fontSize 	      (@editable     textColour 	$$%�    height 	      .@text mix width 	     �Q@ Component type ScriptLabel id gainLabel x 	     �r@y 	     0v@fontName Inter fontSize 	      (@editable     textColour 	$$%�    height 	      .@text gain width 	     �Q@ Processor Type ModulatorChain ID GainModulation Bypassed Intensity 	      �?EditorStates BodyShown 1 Visible 0 Solo 0  ChildProcessors   Processor Type ModulatorChain ID PitchModulation Bypassed Intensity 	        EditorStates BodyShown 1 Visible 0 Solo 0  ChildProcessors   Processor Type EffectChain ID FX Bypassed EditorStates BodyShown 1 Visible 0 Solo 0  ChildProcessors  Processor Type Hardcoded Master FX ID grains Bypassed Network grains width 	        grainPos 	      y@grainSize 	      y@pitch 	        interval 	     @@gain 	        mix 	      I@EditorStates BodyShown 1 Visible 1 Solo 0  ChildProcessors  Processor Type ModulatorChain ID P1 Modulation Bypassed Intensity 	      �?EditorStates BodyShown 1 Visible 0 Solo 0  ChildProcessors   Processor Type ModulatorChain ID P2 Modulation Bypassed Intensity 	      �?EditorStates BodyShown 1 Visible 0 Solo 0  ChildProcessors   Processor Type ModulatorChain ID P3 Modulation Bypassed Intensity 	      �?EditorStates BodyShown 1 Visible 0 Solo 0  ChildProcessors   Processor Type ModulatorChain ID P4 Modulation Bypassed Intensity 	      �?EditorStates BodyShown 1 Visible 0 Solo 0  ChildProcessors   Processor Type ModulatorChain ID P5 Modulation Bypassed Intensity 	      �?EditorStates BodyShown 1 Visible 0 Solo 0  ChildProcessors   Processor Type ModulatorChain ID P6 Modulation Bypassed Intensity 	      �?EditorStates BodyShown 1 Visible 0 Solo 0  ChildProcessors   RoutingMatrix NumSourceChannels    Channel0     Send0 ����Channel1    Send1 ���� Processor Type 
Analyser ID osc Bypassed BufferSize 	      �@PreviewType 	      @EditorStates BodyShown 1 Visible 1 Solo 0  ChildProcessors   RoutingMatrix NumSourceChannels    Channel0     Send0 ����Channel1    Send1 ���� Processor Type WaveSynth ID Waveform Generator1 Bypassed Gain 	      �?Balance 	        VoiceLimit 	      p@KillFadeTime 	      4@IconColour 0 OctaveTranspose1 	        SemiTones1 	        OctaveTranspose2 	        SemiTones2 	        Detune1 	        Detune2 	        WaveForm1 	      @WaveForm2 	      @Pan1 	        Pan2 	        Mix 	      �?EnableSecondOscillator 	      �?PulseWidth1 	      �?PulseWidth2 	      �?HardSync 	        EditorStates BodyShown 1 Visible 1 Solo 0 Folded 1  ChildProcessors  Processor Type MidiProcessorChain ID Midi Processor Bypassed EditorStates BodyShown 1 Visible 0 Solo 0  ChildProcessors   Processor Type ModulatorChain ID GainModulation Bypassed Intensity 	      �?EditorStates BodyShown 1 Visible 0 Solo 0  ChildProcessors  Processor 	Type SimpleEnvelope ID DefaultEnvelope1 Bypassed Monophonic 	        Retrigger 	      �?Intensity 	      �?Attack 	      @Release 	      $@LinearMode 	      �?EditorStates BodyShown 1 Visible 1 Solo 0  ChildProcessors  Processor Type ModulatorChain ID Attack Time Modulation Bypassed Intensity 	      �?EditorStates BodyShown 1 Visible 0 Solo 0  ChildProcessors   Processor Type ModulatorChain ID PitchModulation Bypassed Intensity 	        EditorStates BodyShown 1 Visible 0 Solo 0  ChildProcessors   Processor Type EffectChain ID FX Bypassed EditorStates BodyShown 1 Visible 0 Solo 0  ChildProcessors   Processor Type ModulatorChain ID Mix Modulation Bypassed Intensity 	      �?EditorStates BodyShown 1 Visible 0 Solo 0  ChildProcessors   Processor Type ModulatorChain ID Osc2 Pitch Modulation Bypassed Intensity 	        EditorStates BodyShown 1 Visible 0 Solo 0  ChildProcessors   RoutingMatrix NumSourceChannels    Channel0     Send0 ����Channel1    Send1 ���� RoutingMatrix NumSourceChannels    Channel0     Send0 ����Channel1    Send1 ���� macro_controls  macro name 	Macro 1 value 	        midi_cc ���� macro name 	Macro 2 value 	        midi_cc ���� macro name 	Macro 3 value 	        midi_cc ���� macro name 	Macro 4 value 	        midi_cc ���� macro name 	Macro 5 value 	        midi_cc ���� macro name 	Macro 6 value 	        midi_cc ���� macro name 	Macro 7 value 	        midi_cc ���� macro name 	Macro 8 value 	        midi_cc ���� MidiAutomation   MPEData Enabled  