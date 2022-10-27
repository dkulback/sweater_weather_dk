require 'rails_helper'

RSpec.describe Forecast do
  let(:forecast) do
    Forecast.new({
                   current: {
                     dt: 1_646_501_855,
                     sunrise: 1_646_486_802,
                     sunset: 1_646_528_192,
                     temp: 33.87,
                     feels_like: 21.96,
                     pressure: 1002,
                     humidity: 49,
                     dew_point: 18.45,
                     uvi: 2.52,
                     clouds: 40,
                     visibility: 10_000,
                     wind_speed: 21.85,
                     wind_deg: 270,
                     wind_gust: 27.63,
                     weather: [
                       {
                         description: 'scattered clouds',
                         "icon": '03d'
                       }
                     ]
                   },
                   hourly: [
                     {
                       dt: 1_646_499_600,
                       temp: 33.24,
                       feels_like: 24.53,
                       pressure: 1002,
                       humidity: 47,
                       dew_point: 17.06,
                       uvi: 1.88,
                       clouds: 40,
                       visibility: 10_000,
                       wind_speed: 11.59,
                       wind_deg: 250,
                       wind_gust: 16.11,
                       weather: [
                         {
                           id: 802,
                           main: 'Clouds',
                           description: 'scattered clouds',
                           icon: '03d'
                         }
                       ]
                     }
                   ],
                   daily: [
                     {
                       dt: 1_646_506_800,
                       sunrise: 1_646_486_802,
                       sunset: 1_646_528_192,
                       moonrise: 1_646_493_060,
                       moonset: 1_646_540_400,
                       moon_phase: 0.11,
                       temp: {
                         day: 34.16,
                         min: 19.35,
                         max: 37.24,
                         night: 19.35,
                         eve: 24.17,
                         morn: 23.97
                       },
                       feels_like: {
                         day: 24.49,
                         night: 12.36,
                         eve: 17.71,
                         morn: 13.46
                       },
                       pressure: 1002,
                       humidity: 46,
                       dew_point: 17.38,
                       wind_speed: 15.17,
                       wind_deg: 264,
                       wind_gust: 25.72,
                       weather: [
                         {
                           id: 616,
                           main: 'Snow',
                           description: 'rain and snow',
                           icon: '13d'
                         }
                       ],
                       clouds: 52,
                       pop: 0.36,
                       rain: 0.13,
                       snow: 0.13,
                       uvi: 4.16
                     }
                   ]
                 })
  end
  describe '#initialize' do
    it 'exisits ' do
      actual = forecast
      expected = Forecast
      expect(actual).to be_a(expected)
    end
  end
  describe '#attributes' do
    it 'has a current' do
      actual = forecast.current
      expected = {
        datetime: '2022-03-05 10:37:35',
        sunrise: '2022-03-05 06:26:42 -0700',
        sunset: '2022-03-05 17:56:32 -0700',
        temperature: 33.87,
        feels_like: 21.96,
        humidity: 49,
        uvi: 2.52,
        visibility: 10_000,
        condtions: 'scattered clouds',
        icon: '03d'
      }
    end
    it 'has a hourly' do
      actual = forecast.hourly
      expected = [{ time: '10-00-00', temperature: 33.24, conditions: 'scattered clouds', icon: '03d' }]

      expect(actual).to eq(expected)
    end
  end
end
