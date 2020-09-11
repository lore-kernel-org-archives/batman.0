Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: Passing VID-aware ethernet frames on plain batX interfaces
Date: Fri, 11 Sep 2020 17:03:01 +0200
Message-ID: <1893066.IbdV0THItd@prime>
In-Reply-To: <CADJ1cURdGjW=q91qFw8vCBs38pAPnBp9=e5qS1WgzV7w06Onwg@mail.gmail.com>
References: <CADJ1cURtCsWdy6rovfgb_XPhbsTc5epCv3yLgRCLcOVjfNSFdw@mail.gmail.com> <4337705.76P5Ur0oAU@sven-edge> <CADJ1cURdGjW=q91qFw8vCBs38pAPnBp9=e5qS1WgzV7w06Onwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart43245293.yckCbuvYC3"; micalg="pgp-sha512"; protocol="application/pgp-signature"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Alessandro Bolletta <abolletta@netter.io>, Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <a@unstable.cc>

 
--nextPart43245293.yckCbuvYC3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Alessandro,

to use VLANs in batman-adv, you currently have to explicitly set up VLAN 
interfaces, as it was already explained. You can not just listen to bat0 and 
expected VLAN tagged frames to go through.

This is a limitation of the current code, which basically exists since we 
integrated VLANs into batman-adv. There were some ideas to register VLANs on 
the fly inside of batman-adv, but the current implementation relies on the 
setup of VLANs on top of bat0 provided by the system.

If you want to use those VLANs, you have to set up VLAN interfaces for each 
VLAN ID you want to use. This can get a bit messy if there are many VLANs, but 
it works. You can't just bridge bat0 to something else and expect VLAN tagged 
traffic to come out of bat0.

I can't say anything about OVS and to which extent bridges can be skipped, but 
you'll create VLAN devices in that case too.

We're open to patches to add VLANs on the fly without requiring explicit VLAN 
interfaces (maybe by snooping, similar to TT or BLA). I've also run into this 
scenario a couple of times, but the pain level wasn't high enough to change it 
yet. ;)

Cheers,
       Simon

On Friday, September 11, 2020 4:42:52 PM CEST Alessandro Bolletta wrote:
> Hi Sven,
> 
> I'm sorry for being not so clear in my statements. You can read my
> last "refactored" mail, which is easier to understand:
> 
> Should I must only rely to the related 802.1q interface (eg. bat0.1)
> or can I receive the whole traffic (untagged and tagged) from the
> plain bat0 interface, just listening for the incoming traffic on it?
> 
> If the answer is the first choice, is it possible to have an approach
> where I can receive coming from bat0 leveraging on a single interface
> anyway? Could a linux bridge br0 on the top of bat0 interface make it
> possible?
> 
> For example, if I connect an openvswitch port, configured as trunk port, to
> a linux bridge br0 that enslaves bat0, could I expect to see the whole
> traffic inside the batman-adv mesh network (so I mean, both tagged and
> untagged traffic) also "flowing" inside the other OvS switch ports that are
> attached to that vlans?
> Moreover, just out of curiosity, is there also another known way to
> get rid of the linux bridge br0 in order to get this done (attaching
> the bat0 directly to the OvS switch, for example)?
> 
> Il giorno ven 11 set 2020 alle ore 16:02 Sven Eckelmann
> 
> <sven@narfation.org> ha scritto:
> > On Friday, 11 September 2020 15:03:13 CEST Alessandro Bolletta wrote:
> > > I see. Ok for transmission purposes, but what if I have to receive a
> > > tagged
> > > frame?
> > 
> > It should not have been send to the other node when there is no TT entry
> > for this mac + VID from the receiver.
> > 
> > > Should I only rely to the 8021q interface (eg. bat0.1) or receive the
> > > whole
> > > traffic (untagged and tagged) from the plain bat0 interface?
> > 
> > Hm?
> > 
> > > If this is not feasible, is it possible to handle in someway this?
> > 
> > Hm?
> > 
> > > A linux
> > > bridge on the top of bat0 interface could make it possible?
> > 
> > No, the bridge must also enable the vlan for this bat0 interface.
> > 
> > See also
> > https://www.open-mesh.org/projects/batman-adv/wiki/Faq#BATMAN-Advanced-VLA
> > N-questions
> > 
> > Maybe Antonio wants to add more things to this discussion.
> > 
> > Kind regards,
> > 
> >         Sven


--nextPart43245293.yckCbuvYC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAl9bkaUACgkQoSvjmEKS
nqHhwA/+MmoIKPJ+LvsBZPPCiw32nOwImmwwcgJyH+FYqWRxSM+kT7uIkpKI4i+V
B7qmSZyHA/8RJssCNB4sM8C9PhZNnYRqccbq+u1v17dxYZL8YAKbij7hWsby/v4/
5RgP0zaNV+Wexw5Jj26u6yPXFfmr/tPipHFed+3hPV5wnCn2GZVtdw63O7kgFEy1
CzzpLC3Goyh+NIMH0hi2svr0Qf703zSrCN9r0DrC9RtRxttMtqNrEjED5rTR/6DA
hfzRfT0T8xzMrv0joTs0ddA9jiaXXD0gFPFmLs1URD4v80MHDFvw7vWLHv5iMLTy
5Seo2+E5Jm4TqQsRE0hFgqpRybOzcKn9o5w1vV8Vt8+gH1mBVagSUTHXRimgt6IS
t+vTZr3oe9n5YgiiwTqTv4xcU4xee7LD1+y1csSmBCz2LHkvV12nO6zLKf/4xvWM
DlfmIWWGJ61uGMzg5V/L92kis2bs+sDWI1hgXbH0oNcknoFEtn9lzGlxxaNQ424I
o9kDD8Jusb4a/7yihD0l0YuUgJn861+1bWTx3g1oE058QANKgbhiwD7QYvJM9mll
SvUB++4hY7898N79PNEq4XMzNEcYpWRbca/Z8A1UDvG+e3VaNaGJXwd16ZUPHY7/
2RQOmuzv6nbmGIGEnzfIGFZP4Dy44pP9lxULP/yz7L9ebd5rnAw=
=G8ZG
-----END PGP SIGNATURE-----

--nextPart43245293.yckCbuvYC3--



