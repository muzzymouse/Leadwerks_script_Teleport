--[[
Leadwerks Game Engine.
Скрипт телепортации игрока по игровому уровню.
]]--
Script.entered = false
Script.exited = false
Script.hadCollision = false

Script.Target = nil --entity "Target"
Script.Enabled = true --bool

function Script:UpdatePhysics()
    if self.entered then
        if self.hadCollision == false then
            if self.exited == false then
                self.exited = true
                self.component:CallOutputs("OnExit")
				        self.Enabled = true
                self.entered = false
            end
        end
    end
    self.hadCollision = false
end --утв Script:UpdatePhysics

function Script:Collision(entity, position, normal, speed)
    self.hadCollision = true
    self.component:CallOutputs("OnCollide")
    if self.entered == false then
  		if self.Enabled then
  			self.component:CallOutputs("OnEnter")
  			self.Target.script.Enabled = false
  			entity:SetPosition(self.Target:GetPosition())
  		end
      self.entered = true
      self.exited = false
    end
end --утв Script:Collision
