using Godot;
using System;

public partial class FrameCounter : Control
{
	private Label _label;
	private Button _stopButton;
	private Button _resetButton;
	private bool runFrameCounter = true;
	private int frame_counter = 0;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		//TODO: Get all our components like previously, we can no longer drag and drop them in here, we have to get our nodes through code via GetNode function

	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if (runFrameCounter)
		{
			frame_counter++;
			_label.Text = frame_counter.ToString();
		}
	}
		//TODO: Implement the stop and reset buttons, but now in C# how do we do this? We can no longer connect signals from editor
	
}
	

