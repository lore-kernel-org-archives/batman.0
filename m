Return-Path: <andrew@lunn.ch>
Date: Thu, 22 Oct 2015 02:53:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20151022005325.GB930@lunn.ch>
References: <CAKaWdxbrS90fbV4if4ZhRYtdL-neikMc4iVb_EtowJf8M=9dvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKaWdxbrS90fbV4if4ZhRYtdL-neikMc4iVb_EtowJf8M=9dvg@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Alfred GPS higher update rate
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

On Thu, Oct 22, 2015 at 11:07:48AM +1300, Keith Chew wrote:
> Hi
> 
> I am experimenting with using Alfred on a group of drones (initially
> 10 units) to send their GPS locations to each other.
> 
> The drones will be connected via batman-adv on WIFI, and each of them
> read the GPS every 200ms (5Hz).
> 
> I would like to change alfred-gpsd from updating the GPS coordinates
> every 10s to 200ms.
> 
> Does anyone see any issues with this change? ie it is even feasible/practical?

You need to change more than alfred-gpsd. The core alfred server does
updates every 10 seconds. You need to change ALFRED_INTERVAL so that
it will propagate GPS data faster. If you want 200ms, i doubt such a
change would be accepted back to the core code. So you probably need
to add a command line option to allow setting this interval.

alfred-gpsd will also need some changes. It currently updated the
information in alfred every 2 seconds. You will need to modify this as
well.

When i wrote the alfred-gpsd code, i was not particularly interested
in fast updates. So you might need to change the architecture a
little. In particular, i knew gpsd was giving fixes much faster than
alfred would distribute them, so i didn't tell alfred about every
change. You might need this.

	Andrew
