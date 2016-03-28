Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 28 Mar 2016 22:43:39 +0800
Message-ID: <11401348.Kx9RpUz81r@voltaire>
In-Reply-To: <56F934F9.5000508@t-online.de>
References: <56F5AF2F.6060904@t-online.de> <6005839.o5jWIFZeG0@voltaire>
 <56F934F9.5000508@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3060603.aovYoCzvEF";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3060603.aovYoCzvEF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, March 28, 2016 15:43:21 Roland Volkmann wrote:
> > I am also unclear why this old patch is re-hashed once more since we
> > merged a patch 3 years ago achieving the same goal without a manual knob.
> > Can somebody shed some light on this ?
> > 
> > The patch in question:
> > commit cc1fde312b6d3c010784a80aff9e942e3b16d015
> > Author: Matthias Schiffer <mschiffer@universe-factory.net>
> > Date:   Sat Mar 9 23:14:23 2013 +0100
> > Subject: batman-adv: send each broadcast only once on non-wireless
> > interfaces
>
> this patch/commit addresses another issue than the "new" request 4384: 
> it limits the number of broadcasts to be transmitted on an interface, 
> with the limit automatically adjusting depending of type of interface.
> 
> Request 4384 allows to suppress broadcast packets completely on the 
> interface, where the node has received them (no rebroadcast). This is 
> typical behavior of physical switches, where broadcasts are sent out to 
> all ports except the one, where the packet was received.

Thanks for the clarifications. Given the situation at hand it seem fairly 
simple to extend the existing logic to prevent re-broadcasting on links 
without packet loss.

I am fully aware that adding a setting presents itself as the easiest solution 
but it comes with major drawbacks such as:

 * Once exposed interfaces to user space can never be removed. We have to 
carry this around forever. Thus we need a really good reason to do so.
 * When we let the user decide to configure $something there is a high chance 
the setting ends up being misconfigured and causing frustration in the end.

Prevent rebroadcasts when possible to reduce overhead is a good idea. However, 
I'd like to explore all options to auto-detect whether or not rebroadcasts on 
the same interface are needed or not. The only case requiring investigation is 
the 'tinc without forwarding' and 'without meshing' ? Can you provide insights 
as to what that means and whether or not tinc/fastd 'export' their internal 
state via an interface flag or something along those lines ?

Cheers,
Marek


--nextPart3060603.aovYoCzvEF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW+UMbAAoJEFNVTo/uthzAhoAH/jihoNWqhvOiL6dFj4WNA0Di
aIjQyyeVeDZkwh1UbBaELDrdC6kq8nGK37j0+hqQMhHucG2aLcuQbUTzohg87rKx
ikAH6TJ17oZ79NUsGP7boSn4dFk0PhOLf0kES/YG0GOuJYkXUj8loIE1Llo3mzFu
KNCxg/LgVtNeaT23SBao+5maxF5pRJcLc/949xEQ7wQ9g3OE4eS1xnPRAVMksyxQ
i92OT4G9O/spLUv0gJXLaenH+lvUN3TNhPc+oGb085G4DCCdymoAlYn206wxsCHu
EOMYb6kgsy0pNbJFwhnpywHWkGA9THnD3GTspEOIQA/H5ZXiHLa8I13LDT8R6Hs=
=xZDq
-----END PGP SIGNATURE-----

--nextPart3060603.aovYoCzvEF--

