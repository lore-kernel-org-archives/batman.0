Return-Path: <mschiffer@universe-factory.net>
References: <2ce4491cf3eb01922d0fec97147a1533cca30c41.1435170868.git.mschiffer@universe-factory.net>
 <20150807161622.GB2893@odroid>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <55C4ECD3.3020608@universe-factory.net>
Date: Fri, 7 Aug 2015 19:37:23 +0200
MIME-Version: 1.0
In-Reply-To: <20150807161622.GB2893@odroid>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="geNHxr7bT76WC6TX6qlwDLnhpGhBkJt88"
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: add generic netlink query API
 to replace debugfs files
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--geNHxr7bT76WC6TX6qlwDLnhpGhBkJt88
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2015 06:16 PM, Linus L=C3=BCssing wrote:
> Hi Matthias,
>=20
> here at the Wireless BattleMesh we finally had the chance to get
> some initial discussions on your patch going. For the start a few
> comprehension questions came up:
>=20
>=20
> On Wed, Jun 24, 2015 at 08:34:28PM +0200, Matthias Schiffer wrote:
>> * As batman-adv uses single_open, the whole content of the originators=
/
>>   transglobal files must fit into a single buffer; in large batman-adv=

>>   networks this often fails (as an order-5 allocation or even more wou=
ld be
>>   necessary)
>> * When originators or transglobal aren't just used for debugging, they=
 are
>>   first converted to text, and then parsed again in userspace by tools=
 like
>>   alfred/batadv-vis. Sending MAC address lists from the kernel to user=
space
>>   as text makes the buffer size issue even worse.
>=20
> These two points can be addressed through debugfs too, for
> instance using sequential debugfs writes, right? (In fact IIRC you
> had started with that approach until you got the feedback from
> Gregk, right?)
I've had a look at the different functions the seq_file API provides,
but I didn't write any code.

>=20
> Can you elaborate a little more on the "order-5 allocation"?
> What amount of free RAM did the machines have where we observed
> Out-of-Memory kernel panics upon debugfs access? Can you give some
> numbers / calculations why we ended up with several Megabytes
> memory allocations on debugfs access?
An order-5 allocation are 2^5 =3D 32 pages of memory, i.e. 128K of RAM. A=
s
these are allocated by kmalloc, these 32 pages are allocated as one
piece of physical RAM. As the RAM gets fragmented more and more the
longer a system is running, 32 pages in one piece can be hard to find
even when there are still tens of MB of free RAM.

The fragmentation issue becomes a bit worse because the seq_file code
starts with a single page and loops until the buffer is big enough to
fit the whole output, always freeing the buffer in each loop iteration
and allocation a new buffer twice the size.

>=20
>=20
> The debugfs race conditions Gregk and you talked about are on
> adding/removing debugfs files, right? Are there any known race
> conditions on simple reads/writes in the abscene of removing
> debugfs files?
The race conditions only occur when files are removed, but that alone is
bad enough - I'd really like to avoid enabling debugfs at all on
critical systems.

>=20
>=20
> Since you've had a look at both the netlink and sequential debugfs
> approach already, can you give some estimation about the
> complexity or rough number of lines of code to change for the
> sequential debugfs approach?
I guess that should be possible in 100~200 lines of code. Most of it
would be similar to the code I've implemented for the netlink API:
storing counters between the callback runs to keep track of the current
position in the data structures. Of course, it will have the same
drawbacks: when originator/tt entries are added or removed between the
calls, entries will be duplicate or missing from the output.

The main reason why I didn't consider fixing the debugfs code first was
that returning to userspace in the middle of the read will make the race
conditions much easier to hit: at the moment, the race can only occur
when the file is removed between open() and read(), which is usually
very short. The time between several read() calls can be much bigger,
especially when the files are read and parsed line by line.

>=20
> One thought that popped up here was, whether it'd make sense to
> first "fix" the debugfs approach to the extent possible with a
> couple of lines instead of 800+ lines to get rid of the issues
> we frequently observe. And then merge a complete fix but bigger
> patchset implementing netlink support with a more thorough review
> and discussions on what we'd need for its API now and upcoming
> features.
>=20
> Cheers, Linus
>=20



--geNHxr7bT76WC6TX6qlwDLnhpGhBkJt88
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVxOzTAAoJEBbvP2TLIB2cHHQP/Ap7WTlPD2LIH54kuI+8BJqH
glxoyDLe12fsfolk51odsnjoW2IqL84AAHmRZZBCWsaM2iorNTdJovXOSxOWX1a6
JpnATLYkbeMfyb/C6n7Vq4VSjbbzZAdSYuctcR9qLArDswpPXj73NqawOBUKbYw9
McTgVOJXdwZeCrTX26rIXlYzqVKAY0B8tZ18Hn/+u3/cgG05sGEHAwgzx7VyW1y+
Rw4iNGhH9EL145FDwVHB2+aQKa25BmEFHfcSkwI+F9JX9xcjHto+ihBVaZE3/NL6
T+u3VB8O1IfNhiaSjjXFsfx3DktBz+mUGZtVVF/j6Ud+n8H76ApNXv9A6bSwekq8
QDqocupo2ZSrnba7PAqMtq8foqHpbrsIFR0CEn82bvah1CeOM/h+hCAisN6be1Ex
3W9Wg6x9LSfLuaELHG1CTf7ElmgVEKYvOD1xB6LuDI/4j9AcOovFNIAzlUGZQWV+
w+RO568uXbwOQdnuivoe6ePOT6dw/M9Q5qDSomm4hASVILuanHqULt00kItGO4Vg
avlD6zMJ5ZdVAt4b17wGwUSKl/UYd9cK0yCx0AM4Jvyp/0w05JOj0DHCmHp1qEPq
1paROpTVlHvUMjy8pYFKzo3hAMyRsZW73x7ipW0skLlT93V6kSfAHlZ+AoIRtyo8
Oi25Hf3TV633tzK1aNFs
=CaOD
-----END PGP SIGNATURE-----

--geNHxr7bT76WC6TX6qlwDLnhpGhBkJt88--
