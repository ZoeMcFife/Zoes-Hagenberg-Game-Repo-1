using Godot;
using System;

public partial class FrameCounter : Control
{

	private bool _runFrameCounter = true;
	private int _frameCounter = 0;

	private int _FrameCounter
	{
		get => _frameCounter;
		set
		{
			_frameCounter = value;
			_label.Text = _frameCounter.ToString();
		}
	}
	
	[Export]
	private Label _label;
	
	[Export]
	private Button _stopButton;
	
	[Export]
	private Button _resetButton;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		_stopButton.Pressed += _OnStopPressed;
		_resetButton.Pressed += _OnResetPressed;
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if (!_runFrameCounter) return;
		
		_FrameCounter++;
		_label.Text = _FrameCounter.ToString();
	}

	private void _OnStopPressed()
	{
		_runFrameCounter = !_runFrameCounter;
	}

	private void _OnResetPressed()
	{
		_FrameCounter = 0; 
	}

	public override void _ExitTree()
	{
		_stopButton.Pressed -= _OnStopPressed;
		_resetButton.Pressed -= _OnResetPressed;
	}
}
	

