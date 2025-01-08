Config = {}

Config.RestrictedChannels = {
  [112] = {
    police = true
  },
  [114] = {
    ambulance = true
  },
  [113] = {
    police = true,
    ambulance = true
  }
} 

Config.MaxFrequency = 500

Config.messages = {
  ['not_on_radio'] = 'You\'re not connected to a signal',
  ['on_radio'] = 'You\'re already connected to this signal',
  ['joined_to_radio'] = 'You\'re connected to: ',
  ['restricted_channel_error'] = 'You can not connect to this signal!',
  ['invalid_radio'] = 'This frequency is not available.',
  ['you_on_radio'] = 'You\'re already connected to this channel',
  ['you_leave'] = 'You left the channel.'
}