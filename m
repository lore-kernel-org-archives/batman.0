Return-Path: <andrew@lunn.ch>
Date: Wed, 2 Oct 2013 10:28:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20131002082830.GA16339@lunn.ch>
References: <1380659032-14488-1-git-send-email-andrew@lunn.ch>
 <1380659032-14488-2-git-send-email-andrew@lunn.ch>
 <1380698731.22367.28956361.6696D00A@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1380698731.22367.28956361.6696D00A@webmail.messagingengine.com>
Subject: Re: [B.A.T.M.A.N.] [PATCHv1] alfred: Add support for passing
 location information over alfred.
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Janne Paatero <janne.paatero@ruag.com>

On Wed, Oct 02, 2013 at 09:25:31AM +0200, Thijs van Veen wrote:
> Hello Andrew (and the rest of the list),
> 
> On Tue, Oct 1, 2013, at 22:23, Andrew Lunn wrote:
> > +Alfred-gpsd
> > +-----------
> > +
> > +Alfred-gpsd can be used to distibute GPS location information about
> > +your batman-adv mesh network. This information could be, for example,
> > +combined with Vis to visualize your mesh topology with true geographic
> > +layout. For mobile or nomadic nodes, Alfred-gpsd, can get location
> > +information from gpsd.  Alternatively, a static location can be passed
> > +on the command line, which is useful for static nodes without a GPS.
> > +
> > +Alfred-gpsd, similar to to alfred, combines server (daemon) and client
> > +functionality in the 'alfred-gpsd' binary. The alfred-gpsd server must
> > +be started to distribute location information. When retrieving
> > +location information from gpsd, it should be started with:
> > +
> > + $ alfred-gpsd -s
> > +
> > +For a static location, use:
> > +
> > + $ alfred-gpsd -s -l 48.858222,2.2945,358
> > +
> > +This server will set the location in alfred via unix
> > +socket. Obviously, the alfred server must run too to get this
> > +information set. When using gpsd, it updates alfred every 2
> > +seconds. With a static location, the update it made every 5 minutes.
> > +
> > +To get JSON formatted output, use:
> > +
> > + $ alfred-gpsd
> > +[
> > +  { "source" : "f6:00:48:13:d3:1e", "tpv" :
> > {"class":"TPV","tag":"RMC","device":"/dev/ttyACM0","mode":3,"time":"2013-10-01T10:43:20.000Z","ept":0.005,"lat":52.575485000,"lon":-1.339716667,"alt":122.500,"epx":10.199,"epy":15.720,"epv":31.050,"track":0.0000,"speed":0.010,"climb":0.000,"eps":31.44}
> > },
> > +  { "source" : "8e:4c:77:b3:65:b4", "tpv" :
> > {"class":"TPV","device":"command
> > line","time":"2013-10-01T10:43:05.129Z","lat":48.858222,"lon":2.2945,"alt":358.000000,"mode":3}
> > }
> > +]
> > +
> > +See gpsd_json(5) for documentation of the tpv object. 
> 
> As there are many different ways to display GPS coordinates, I suggest
> adding the format in which the data will be reported to the
> documentation.

This would be quite a bit of information, so i would probably put in
into an alfred-gpsd specific README, not the Alfred README.

> In my time playing with gps positioning (just a couple of weeks), I've
> run into at least 4 different latitude/longitude formats, most of which
> look very much alike, but all of which are incompatible with each other,
> so it's important to know which format is used.
> 
> Specifically, gpsd parses (standard) NMEA messages, which give position
> as hybrid of integer degrees and decimal arc minutes (ddmm.mmmm)
> followed by a direction (NSEW).
> When displayed in raw mode, gpsd will return these NMEA formatted
> values; the JSON output however (which is used) returns pure decimal
> degrees (dd.dddddd), with the sign specifying direction (NW are
> positive, SE are negative if I'm not mistaking).
> 
> I know the format is specified in the gpsd_json man page (which is
> referenced), but it seems more user-friendly to me to have the output
> format described here as well.

The gpsd_json documentation is not very specific:

           ├───────┼─────────┼─────────┼────────────────────────┤
           │lat    │ No      │ numeric │ Latitude in degrees:   │
           │       │         │         │ +/- signifies          │
           │       │         │         │ West/East.  Present    │
           │       │         │         │         when mode is 2 │
           │       │         │         │ or 3.                  │
           ├───────┼─────────┼─────────┼────────────────────────┤
           │lon    │ No      │ numeric │ Longitude in degrees:  │
           │       │         │         │ +/- signifies          │
           │       │         │         │ North/South. Present   │
           │       │         │         │         when mode is 2 │
           │       │         │         │ or 3.                  │
           ├───────┼─────────┼─────────┼────────────────────────┤

It just says degrees, not "pure" degrees, "not hybrid" degrees, etc.
So importing the gpsd documentation does not really clarify it more.
I'm also hesitant to add additional documentation, above what
gpsd_json says. I've just implemented a "dumb pipe". I don't interpret
the data in any way, i don't guarantee that the format will never
change etc.

> Seeing as there is a member gpsd_format, I'm assuming this is meant to
> allow for different formatting in the future, which makes it even more
> important to explicitly state how the values are formatted.

No, that is not why i added the tpv gpsd_format. I will probably need
the ATT, the vehicle-attitude report, to report what direction my
directional antennae are pointing. I've no intentional of adding other
location formats, eg raw NMEA. That just added complexity i don't want
to handle.
 
> Other than that, this looks very promising.

Thanks
	Andrew
