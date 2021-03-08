format_version = "1.0"

rtc_bindings = { 
  { source = "/environment/system_sample_rate", dest = "/global_rtc/init_instance" },
  { source = "/environment/instance_id", dest = "/global_rtc/init_instance" },
 -- { source = "/custom_properties/triggerMode", dest="/global_rtc/trigger_mode_change" }
}

global_rtc = { 

  init_instance = function(source_property_path, instance_id)
    local new_no = jbox.make_native_object_rw("Instance", {instance_id})
    jbox.store_property("/custom_properties/instance", new_no);
  end,
  trigger_mode_change = function(source_property_path, value)
    local v = value==1
    jbox.store_property("/custom_properties/extEnabled", v)
  end
}

sample_rate_setup = { 
native = {
    22050,
    44100,
    48000,
    88200,
    96000,
    192000
  },
}

rt_input_setup = { 
  notify = {
  "/custom_properties/trigger",
  "/custom_properties/triggerMode",
  "/custom_properties/shape",
  "/custom_properties/pitch",
  "/custom_properties/length",
  "/custom_properties/pan",
  "/custom_properties/amplitude",
  "/custom_properties/limiter",
  "/custom_properties/limiterOnOff",
  "/custom_properties/limiterHardSoft",
  "/custom_properties/vcoFrequency",
  "/custom_properties/externalTriggerThreshold",
  "/custom_properties/externalTriggerDebounce",
  "/custom_properties/vcoHold",
  "/custom_properties/vcoModulatorActive",
  "/cv_inputs/trigger",
  "/transport/request_reset_audio",
  "/environment/master_tune",
  "/environment/system_sample_rate"
  }
}

