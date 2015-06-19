Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 19 Jun 2015 13:50:45 +0800
Message-ID: <2071356.udBP3C0Di5@voltaire>
In-Reply-To: <55831C89.9030707@meshcoding.com>
References: <1434596669-9597-1-git-send-email-mareklindner@neomailbox.ch>
 <55831C89.9030707@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2330139.1sfiXgBfMV";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: fix kernel crash due
	to missing NULL checks
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart2330139.1sfiXgBfMV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 18, 2015 21:31:21 Antonio Quartulli wrote:
> WARN returns the value of the expression passed as first argument,
> therefore you can directly pass "!vlan" and use the whole macro
> invocation as if condition.

I am aware of this 'feature'  but I don't find it readable enough. In the Linux 
kernel I found several code sections using the proposed style too which made 
me favor it. Do you insist on changing that ?


> Note: if you are going to merge this patch before Sven's one you need to
> also include bug.h.

Ok.

Cheers,
Marek

--nextPart2330139.1sfiXgBfMV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVg625AAoJEFNVTo/uthzAnO0IAI/u88TEvIBOq9/zaz5dGVbx
s1KtfoRkDDqTKX7pljDOGbPM70dKVH4bf9G/JO2rWvb6OxkZU3PmH5NzQyGGjANH
EXCznjwP51b4d7iorLcRykj551ffxMzjxfAbEJLCKVzcQRaFMuQKp9sJRj7sVN+P
4lpGwnk7J5ssZhWB6Uml4yp5TCagkFPpoohUj4VV2Kk6aa6vIoUw1whflgT9A1To
lB7Od1yCuKdjbiPg5AlglxMJHJgUUsp33qD5unhcqZoFub/199WjCde4uxh8oM/W
YmqtBRWbZNtUvT9uvSMX6tDAP7qC886zH6kGN7QV/3IFI/QGFvs/KavmIV9HpN8=
=SVMv
-----END PGP SIGNATURE-----

--nextPart2330139.1sfiXgBfMV--

