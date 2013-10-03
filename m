Return-Path: <andrew@lunn.ch>
Date: Thu, 3 Oct 2013 10:11:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20131003081124.GA20056@lunn.ch>
References: <20131001202648.GT11097@lunn.ch>
 <20131002130548.GA24077@pandem0nium>
 <20131002160106.GA1939@neomailbox.net>
 <524D0A04.4090702@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <524D0A04.4090702@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] Alfred batadv-vis json conformance
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

On Thu, Oct 03, 2013 at 08:09:08AM +0200, Martin Hundeb=F8ll wrote:
> On 2013-10-02 18:01, Antonio Quartulli wrote:
> >On Wed, Oct 02, 2013 at 03:05:48PM +0200, Simon Wunderlich wrote:
> >>>> >I'm also wondering if label and gateway could have more meaningful
> >>>> >names? TQ and host? Also, is TT the best?
> >>>
> >>>Hm, that is a good question. We also have the batman v with new metrics
> >>>coming up, I'm not sure how to handle these (maybe Antonio has some
> >>>idea?). It is not the TQ-value in the label after all, but some kind of
> >>>ETX-converted value (255/TQ if i remember correctly).
> >I think the ETX stuff comes from OLSR (but I don't know the details).
> >
> >I agree with Simon that we should find a generic name (e.g. metric ?) bu=
t I am
> >not sure we can represent this value in a "algorithm-generic" fashion (a=
nd maybe
> >we don't want to).
>=20
> May I suggest that the cjson output includes an entry to tell the
> version of the batman-algorithm?
>=20
> Users might want to do different map overlays (or whatever)
> depending on the available metric(s).
=20
Hi Martin

I did think about that, but i'm not sure how. The cjson format is the
simple bit. I can add an outer layer with more key:value
pairs. Something like this:

batadv-vis -f cjson
{
  "algorithm" : 4,
  "source_version" : "2013.4.0-g6b13699",
  "vis" : [
    { "primary" : "fe:f0:00:00:04:01",
      "neighbors" : [
         { "router" : "fe:f0:00:00:04:01",
           "neighbor" : "fe:f0:00:00:05:01",
           "metric" : "1.000" },
         { "router" : "fe:f0:00:00:04:01",
           "neighbor" : "fe:f0:00:00:03:01",
           "metric" : "1.008" }
      ],
      "clients" : [
         "00:00:43:05:00:04",
         "fe:f1:00:00:04:01"
      ]
    },
...
  ]
}

But how do we determine the algorithm version? For the moment it can
simply be hard coded. But for version 5? Will the over-alfred format
change? Will we have a "struct vis_v2" and VIS_PACKETVERSION_2 for
algorithm 5?

Thanks
	Andrew
