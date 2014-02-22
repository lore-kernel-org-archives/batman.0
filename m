Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 22 Feb 2014 21:20:43 +0800
Message-ID: <14218846.TP5slI6GEB@diderot>
In-Reply-To: <D8FCFBAF-224C-454D-B86C-D57641FB0DF1@gmx.de>
References: <4F5A043B-6BFB-46F0-9D14-BDF07F2533E0@gmx.de>
 <5305C654.5020605@meshcoding.com>
 <D8FCFBAF-224C-454D-B86C-D57641FB0DF1@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart464362207.3H3N7UdOXh";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Suggestion for routing improvement on poor links
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


--nextPart464362207.3H3N7UdOXh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 20 February 2014 11:20:01 whangarei & opua wrote:
> The setup is like this:
> whangarei is my router, it has one Wlan link to each of this 3  
> neighbor router, MAC in the grep, hostname as comment.
> This 3 routers are in one large building (across a park) but sometimes  
> don't see each other. 2 of them have VPN connects.
> I've looked only to the next hop, by grep the lines beginning with the  
> MAC of this neighbor routers.
> The intension was to get a better feeling of the link quality then  
> with the 'iw dev wlan0-1 station dump' output.
> So i have observed this behavior...
> 
> Have attached the router output as a file, it should be more readable.

Unfortunately, the information you provided isn't comprehensive enough to 
comment on your case. Please take a look at bat-hosts to have meaningful names 
in your originator table. Furthermore, we need a clear description of your 
setup for what the routing concerns. You can take a look at our routing 
scenarios page to get a feeling what we usually work with:
http://www.open-mesh.org/projects/open-mesh/wiki/Routing_scenarios

A diagram is no must but certainly helpful.

As soon as we have a clearer understanding of how your setup looks like, you 
can explain what behavior you see and what you would expect, plus originator 
tables from each node involved.

Cheers,
Marek

--nextPart464362207.3H3N7UdOXh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTCKQrAAoJEFNVTo/uthzAJAoH/2sW5fSsnYtH6rr/XPkbQI8w
auaCVjHd+LjWRlWj7Cl1hgNvh5awdUMVghcTqOtH7PdHEsYeV0GVo1yckPW463c+
IntMDFujF+/cUYnrxlBtO532cUbiZ/kkzzfV0o2+ZZfIHDhrv5T1JdfYCFF40tLT
Rhz5I4PjhjzTwtmU2lGONvDVMfIAdnyOwV7KjR3G5Zqw+6RktIrBbzZf0WPDP+FA
PKL2F/xBRAIMahelVS24UJULhX43PYVnjZkyG3vmdV0CjR5vuXTDSO6graNZ5IpC
EnYBPS/AQXOmXezX3kuxg2ImNzvZZnwPA++mo2wy3uL95hHsNF3Bjm73IBOHGEQ=
=saRm
-----END PGP SIGNATURE-----

--nextPart464362207.3H3N7UdOXh--

