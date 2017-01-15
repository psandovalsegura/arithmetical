//
//  Track.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 1/13/17.
//  Copyright © 2017 Sandoval Software. All rights reserved.
//

import Foundation

class Track: NSObject {
    
    //The fields below are set by the getFullTrack API call
    var duration: Int?
    var id: String?
    var uri: String?
    var name: String?
    var albumImageUrl: String?
    
    //var albumImage: UIImage?
    var albumName: String?
    var artistName: String = ""
    var artists = [Artist]()
    
    
    
    //The fields below are set by the getFullTrack API call
    var danceability: Double? //how suitable a track is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength, and overall regularity. A value of 0.0 is least danceable and 1.0 is most danceable.
    var acousticness: Double? //from 0.0 to 1.0 of whether the track is acoustic. 1.0 represents high confidence the track is acoustic
    var energy: Double? //from 0.0 to 1.0 and represents a perceptual measure of intensity and activity. Typically, energetic tracks feel fast, loud, and noisy
    var liveliness: Double? //Detects the presence of an audience in the recording, value above 0.8 provides strong likelihood that the track is live.
    var loudness: Double? //overall loudness of a track in decibels (dB)
    var speechiness: Double? //Speechiness detects the presence of spoken words in a track
    var valence: Double? //from 0.0 to 1.0 describing the musical positiveness conveyed by a track
    init(dictionary: NSDictionary) {
        super.init()
        self.duration = dictionary["duration_ms"] as? Int
        self.id = dictionary["id"] as? String
        self.uri = dictionary["uri"] as? String
        self.name = dictionary["name"] as? String
        
        //Additional information loaded in getAudioFeatures (helper method) of Spotify Client
        //When tracks are initialized from getAlbumTracks Spotify API call, track objects do not have album references
        if let albumDictionary = dictionary["album"] as? NSDictionary {
            self.albumName = albumDictionary["name"] as? String
            if let imagesArray = albumDictionary["images"] as? [NSDictionary] {
                let thumbnail = imagesArray[0]
                self.albumImageUrl = thumbnail["url"] as? String
            }
        }
        
        
        let artistDictionaries = dictionary["artists"] as? [NSDictionary]
        for artistDictionary in artistDictionaries! {
            let currentArtist = Artist(dictionary: artistDictionary)
            self.artists.append(currentArtist)
        }
        
        //Constructing artist(s) string
        if (artists.count == 1) {
            artistName = artists[0].name!
        } else {
            for artist in self.artists {
                if (artist != self.artists[self.artists.endIndex - 1]) {
                    self.artistName += (artist.name! + ", ")
                } else {
                    self.artistName += (artist.name!)
                }
            }
            
        }
    }
}
