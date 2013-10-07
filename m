Return-Path: <andrew@lunn.ch>
Date: Mon, 7 Oct 2013 11:00:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20131007090028.GB3391@lunn.ch>
References: <20131001202648.GT11097@lunn.ch>
 <20131002130548.GA24077@pandem0nium>
 <20131002133600.GD16339@lunn.ch> <525120D8.10508@altermundi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <525120D8.10508@altermundi.net>
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

On Sun, Oct 06, 2013 at 10:35:36AM +0200, Nicol=E1s Ech=E1niz wrote:
> El 02/10/13 15:36, Andrew Lunn escribi=F3:
> > On Wed, Oct 02, 2013 at 03:05:48PM +0200, Simon Wunderlich wrote:
> >> Hey Andrew,
> >>
> >> On Tue, Oct 01, 2013 at 10:26:48PM +0200, Andrew Lunn wrote:
>=20
> >> Yes, it is only JSON line-wise, but not the whole output. This output =
format
> >> however is the same as we have/had in the batctl JSON output which com=
es
> >> from the kernel (I think that was your contribution in the first place=
?).
> >>
> >> Therefore I'd like to leave this old format as it is to allow communit=
ies
> >> to seamlessly switch from batctl json vis to alfred-vis.
> >=20
> > That is what i was expecting. So when i did the first implementation
> > this morning, i added a new format, cjson, for conforming json. Not
> > the best of names, but i could not think of anything better.
>=20
> maybe jsondoc would be more explicit, as it differentiates the output
> from the current json(lines) format.

Hi Nico

Yes, i link it. Another patch version coming soon.

     Thanks
          Andrew
