# To change this template, choose Tools | Templates
# and open the template in the editor.

module A2mConfiguration

  def self.get_value(group_name, ckey, default_value)
    ret=default_value
    c_conf=get_config(group_name, ckey)

    if c_conf and !c_conf.cvalue.blank?
      ret=c_conf.cvalue
    end

    ret
  end

  def self.get_config(group_name, ckey)
    c_group=Confgroup.find_by_name(group_name)
    if !c_group
      c_group = Confgroup.create(:name=>group_name)
    end
    c_conf = Confitem.find(:first, :conditions=>{:confgroup_id=>c_group.id, :ckey=>ckey})

    if !c_conf
      c_conf = Confitem.create(:confgroup=>c_group, :ckey=>ckey, :cvalue=>"")
    end

    c_conf
  end

  def self.set_value(group_name, ckey, default_value)
    c_group = Confgroup.find_by_name(group_name)
    if !c_group
      c_group = Confgroup.create(:name=>group_name)
    end
    c_conf = Confitem.find(:first, :conditions=>{:confgroup_id=>c_group.id, :ckey=>ckey})
    if !c_conf
      c_conf = Confitem.create(:confgroup=>c_group, :ckey=>ckey, :cvalue=>default_value)
    else
      c_conf.cvalue = default_value
      c_conf.save
    end
  end
end
