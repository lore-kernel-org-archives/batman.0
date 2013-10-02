Return-Path: <dicht@operamail.com>
Message-Id: <1380698731.22367.28956361.6696D00A@webmail.messagingengine.com>
From: Thijs van Veen <dicht@operamail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Date: Wed, 02 Oct 2013 09:25:31 +0200
In-Reply-To: <1380659032-14488-2-git-send-email-andrew@lunn.ch>
References: <1380659032-14488-1-git-send-email-andrew@lunn.ch>
 <1380659032-14488-2-git-send-email-andrew@lunn.ch>
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

Hello Andrew (and the rest of the list),

On Tue, Oct 1, 2013, at 22:23, Andrew Lunn wrote:
> +Alfred-gpsd
> +-----------
> +
> +Alfred-gpsd can be used to distibute GPS location information about
> +your batman-adv mesh network. This information could be, for example,
> +combined with Vis to visualize your mesh topology with true geographic
> +layout. For mobile or nomadic nodes, Alfred-gpsd, can get location
> +information from gpsd.  Alternatively, a static location can be passed
> +on the command line, which is useful for static nodes without a GPS.
> +
> +Alfred-gpsd, similar to to alfred, combines server (daemon) and client
> +functionality in the 'alfred-gpsd' binary. The alfred-gpsd server must
> +be started to distribute location information. When retrieving
> +location information from gpsd, it should be started with:
> +
> + $ alfred-gpsd -s
> +
> +For a static location, use:
> +
> + $ alfred-gpsd -s -l 48.858222,2.2945,358
> +
> +This server will set the location in alfred via unix
> +socket. Obviously, the alfred server must run too to get this
> +information set. When using gpsd, it updates alfred every 2
> +seconds. With a static location, the update it made every 5 minutes.
> +
> +To get JSON formatted output, use:
> +
> + $ alfred-gpsd
> +[
> +  { "source" : "f6:00:48:13:d3:1e", "tpv" :
> {"class":"TPV","tag":"RMC","device":"/dev/ttyACM0","mode":3,"time":"2013-10-01T10:43:20.000Z","ept":0.005,"lat":52.575485000,"lon":-1.339716667,"alt":122.500,"epx":10.199,"epy":15.720,"epv":31.050,"track":0.0000,"speed":0.010,"climb":0.000,"eps":31.44}
> },
> +  { "source" : "8e:4c:77:b3:65:b4", "tpv" :
> {"class":"TPV","device":"command
> line","time":"2013-10-01T10:43:05.129Z","lat":48.858222,"lon":2.2945,"alt":358.000000,"mode":3}
> }
> +]
> +
> +See gpsd_json(5) for documentation of the tpv object. 

As there are many different ways to display GPS coordinates, I suggest
adding the format in which the data will be reported to the
documentation.
In my time playing with gps positioning (just a couple of weeks), I've
run into at least 4 different latitude/longitude formats, most of which
look very much alike, but all of which are incompatible with each other,
so it's important to know which format is used.

Specifically, gpsd parses (standard) NMEA messages, which give position
as hybrid of integer degrees and decimal arc minutes (ddmm.mmmm)
followed by a direction (NSEW).
When displayed in raw mode, gpsd will return these NMEA formatted
values; the JSON output however (which is used) returns pure decimal
degrees (dd.dddddd), with the sign specifying direction (NW are
positive, SE are negative if I'm not mistaking).

I know the format is specified in the gpsd_json man page (which is
referenced), but it seems more user-friendly to me to have the output
format described here as well.
Seeing as there is a member gpsd_format, I'm assuming this is meant to
allow for different formatting in the future, which makes it even more
important to explicitly state how the values are formatted.

Other than that, this looks very promising.

-- 
  Thijs van Veen
  dicht@operamail.com


-- 
http://www.fastmail.fm - Does exactly what it says on the tin

