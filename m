From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Node keeps switching back and forth
Date: Wed, 16 Apr 2008 02:02:23 +0800
References: <7BE4D55B-B938-45A8-BCF4-923632152CFC@philippeapril.com>
	<a934d3f30804150104w4c4c47fp766cce05ae014ae2@mail.gmail.com>
	<018CC2A5-4DD5-421B-AD00-AF9B3CC50D2B@philippeapril.com>
In-Reply-To: <018CC2A5-4DD5-421B-AD00-AF9B3CC50D2B@philippeapril.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Disposition: inline
Message-Id: <200804160202.23971.lindner_marek@yahoo.de>
Content-Transfer-Encoding: 8bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


> As soon as signal from node2 to node1 goes down from let's say 250 to
> 240, if another connection to the gateway's quality is 241, it'll
> switch as soon as it hits 240... Then when quality comes back up to
> 242, it switches back to node1.
>
> I don't think it's very good to switch as soon as the quality is
> higher somewhere else, it should at least "give it a chance" by either
> having a threshold, or switch only if it's been in a more degraded
> state for more than x minutes, etc.
>
> Is there something I can do to influence that? Did I miss a command
> line argument?

You can use e.g. "-r 20" to switch the gateway as soon as the TQ difference is 
bigger than 20.

From "batmand -H":

-r routing class (only needed if gateway class = 0)
          default:         0  -> set no default route
          allowed values:  1  -> use fast internet connection (gw_flags * TQ)
                           2  -> use stable internet connection (TQ)
                           3  -> use fast-switch internet connection (TQ but 
switch as soon as a better gateway appears)

                           XX -> use late-switch internet connection (TQ but 
switch as soon as a gateway appears which is XX TQ better)

Greetings,
Marek

