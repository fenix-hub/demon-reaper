extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var phrase = 0
var dialouge = ["Welcome, demon. I am Doropu, your supervisor. \nIf you are here, it means that you are the new in charge of the -Possess and Sacrifice- section. \nSince what they taught during the apprenticeship is completely useless here in Daemonia -as you know, the land between light and darkness-, listen carefully to my directions and you will survive (hopefully) more than you expect.","On the left of this area you can find Mephi: his job is trading all the humanity fragments you collected in the Overworld with some power ups, just for you! \nOn the right of this area you can find Daphne: you can sacrifice to her all the humans you possessed, and in exchange of those sacrifices you can increase some parameters which will help you last longer in the Overworld.","Now, the most important part. \nOn the bottom of the map you can find an entrance: this will lead you to the Overworld. \nOnce you are in the Overworld you can come back whenever you want, BUT if you try to go back to the Overworld from here, you will lose everything you have earned there, and you will have to do everything again. So remember: come back here only if you are sure you have something worthy to trade. These bad guys will not compromise!","Exploring the Overworld you will notice that each human has some humanity fragments and some guardians protecting them. Find the prey you like, and attack him to occupy his soul.\nSince you are new and weak, you only have a little time to succeede in possessing his humanity. \nIf you die, you die. You will get back here with your hands empty. \nIf the time ends, you will be immediately kicked out from the soul, and the human will vanish.","If you succeede in possessing the human, you will earn his humanity fragments, and also you will possess his guardians based on your control power (you can increase it talking with Daphne).\nThe guardians you possessed will fight with you until death, and they will abandon you when you come back here.\nOne last thing.... every time you succeed in possessing a human, the guardians of those left in the Overworld will become more and more strong. Be careful."]
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused=true
	$ColorRect/RichTextLabel.text = dialouge[phrase]
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
	if Input.is_action_just_pressed("melee"):
		if phrase<dialouge.size():
			print(str(dialouge.size()))
			if $ColorRect/RichTextLabel.visible_characters<dialouge[phrase].length() and $ColorRect/RichTextLabel.visible_characters>4:
				$ColorRect/RichTextLabel.visible_characters=dialouge[phrase].length()
			elif phrase<dialouge.size()-1:
				phrase=phrase+1
				$ColorRect/RichTextLabel.visible_characters=0
				$ColorRect/RichTextLabel.text=dialouge[phrase]
			else:
				get_parent().get_parent().get_parent().get_parent().some_ui_open=false
				get_tree().paused=false
				queue_free()

func _on_Timer_timeout():
	if $ColorRect/RichTextLabel.visible_characters < dialouge[phrase].length():
		$ColorRect/RichTextLabel.visible_characters+=1
