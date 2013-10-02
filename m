Return-Path: <andrew@lunn.ch>
Date: Wed, 2 Oct 2013 18:47:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20131002164754.GE16339@lunn.ch>
References: <1380659032-14488-1-git-send-email-andrew@lunn.ch>
 <1380659032-14488-2-git-send-email-andrew@lunn.ch>
 <20131002131915.GB24077@pandem0nium>
 <2038458.nCDZnQrXiI@sven-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2038458.nCDZnQrXiI@sven-desktop>
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
Cc: "Janne.Paatero@ruag.com" <Janne.Paatero@ruag.com>

On Wed, Oct 02, 2013 at 06:34:15PM +0200, Sven Eckelmann wrote:
> On Wednesday 02 October 2013 06:19:15 Simon Wunderlich wrote:
> > > +# alfred build
> > > +BINARY_NAME = alfred-gpsd
> > > +OBJ = alfred-gpsd.o
> > > +
> > > +# alfred flags and options
> > > +CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
> > > +LDLIBS += -lgps
> > 
> > I have no idea if we need some special handling for this to let it work
> > for crosscompiling, OpenWRT etc?
> 
> Please use pkg-config for things like this. An example Makefile is attached.

Hi Sven

Thanks for the Makefile. Works on my Debian system.

       Andrew
