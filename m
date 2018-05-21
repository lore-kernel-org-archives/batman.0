Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 21 May 2018 16:32:41 +0200
Message-ID: <2341018.vaZVR3cbJE@sven-edge>
In-Reply-To: <20180521104923.GI7162@otheros>
References: <20180515155908.23839-1-linus.luessing@c0d3.blue>
 <1566281.z125QuZFdt@sven-edge> <20180521104923.GI7162@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2373697.kK5g5fdpHx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] batman-adv: Snoop DHCPACKs for DAT
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

--nextPart2373697.kK5g5fdpHx
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 21. Mai 2018 12:49:23 CEST Linus L=FCssing wrote:
[...]
> > And what about the basically duplicated bootp_pkt definition in net/ipv=
4/
> > ipconfig.c?
>=20
> Would it make sense to first add it to distributed-arp-table.c and
> then later I'd make a second patch directly for netdev@ to unify those?

I think this could work.

On Montag, 21. Mai 2018 13:04:40 CEST Linus L=FCssing wrote:

> Hm, I guess there's nothing I could do about that unaligned
> access other than suppressing any potential warnings? I guess
> since DHCP ACKs are relatively rare compared to other traffic in
> fast path I think the performance impact should be negligible.

No, it triggers the unaligned acccess exception and some architectures will=
=20
not even be able to work around them [1].

> What was the magic command to check unaligned accesses during
> runtime again?

I think the debugfs infrastructure can be used to debug this [2]

    echo 2 >/sys/kernel/debug/mips/unaligned_action

neoraider used vxlan between outer ethernet header and batman-adv to=20
"misalign" such fields by two bytes.

> With the preceding "#pragma pack(2)" any warnings should be
> suppressed already, shouldn't they?

No, you cast these fields to __be32 * and then access them. The pointer wil=
l=20
therefore be accessed with the assumption that it is aligned correctly (4=20
bytes boundary for MIPS). This will cause an exception on those machines.

Let me show you some examples. Let us first start with an direct access of =
a=20
struct member:

    $MIPS_GCC/mips-openwrt-linux-musl-gcc -O1 -x c -S - -o - << EOF
    #include <stdint.h>
    struct test {
            uint32_t test1;
            uint32_t test2;
    };
   =20
    uint32_t test(struct test *t)
    {
            return t->test2;
    }
    EOF

You will get a simple function with a single (32 bit) load which also requi=
res=20
the 4 byte alignment:

    test:
            .frame  $sp,0,$31
            .mask   0x00000000,0
            .fmask  0x00000000,0
            .set    noreorder
            .set    nomacro
            lw      $2,4($4)
            j       $31
            nop


Now let us add the pragma which to reduce it to a 2 byte alignment=20
requirement:

    $MIPS_GCC/mips-openwrt-linux-musl-gcc -O1 -x c -S - -o - << EOF
    #include <stdint.h>
    #pragma pack(2)
    struct test {
            uint32_t test1;
            uint32_t test2;
    };
    #pragma pack()
   =20
    uint32_t test(struct test *t)
    {
            return t->test2;
    }
    EOF

This will create two different loads to get the complete 32 bit word when o=
nly=20
2 byte alignment is guaranteed

    test:
            .frame  $sp,0,$31
            .mask   0x00000000,0
            .fmask  0x00000000,0
            .set    noreorder
            .set    nomacro
            lwl     $2,4($4)
            nop
            lwr     $2,7($4)
            j       $31
            nop

And now we convert all this to your method of indirect access (uint32_t=20
pointer):

    $MIPS_GCC/mips-openwrt-linux-musl-gcc -O1 -x c -S - -o - << EOF
    #include <stdint.h>
    #pragma pack(2)
    struct test {
            uint32_t test1;
            uint32_t test2;
    };
    #pragma pack()
   =20
    uint32_t test(struct test *t)
    {
            uint32_t *t2 =3D &t->test2;
            return *t2;
    }
    EOF

You will see that this will again only be a single 32 bit load which requir=
es=20
4 byte alignment (and thus will cause an CPU exception when it is only 2 by=
te=20
aligned):

    test:
            .frame  $sp,0,$31
            .mask   0x00000000,0
            .fmask  0x00000000,0
            .set    noreorder
            .set    nomacro
            lw      $2,4($4)
            j       $31
            nop

Kind regards,
	Sven

[1] https://www.kernel.org/doc/Documentation/unaligned-memory-access.txt
[2] https://www.linux-mips.org/wiki/Alignment#Transparent_fixing_by_the_ker=
nel
--nextPart2373697.kK5g5fdpHx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsC2IkACgkQXYcKB8Em
e0YRfRAAiU+YLemJ6IwrZDhECP+9amwaOItq7EU6z6BhoClr72G3AMa79+H/Kylc
omG9N8EAM/TRH6AI2KU/zeUqSBI95PGUsTIKgmlnQjWx5EB8pqz2IPr5fteLBlwK
q3M2/wY80lzmZVDBzD8P48AtLqX6gndacFLayNl7wUG6Fx3cdQ7PNniwil6nSGjX
raQq46f42tk1Q3fUn6Zbpe5nmV0b7IwktVeOnR0NDm16XlakFAYNcyaLEEok+D0q
XUXbheXt0H6Hlaf3vgHaTYzx8Zi3b5oILZmmH2x2fITrhCwF8Y0on1zoBkUKNxNi
ioR+h+zAbwY/CtoQR2di8R6lWc+vF8bZrHjaA5dEIa5hR7n4H2AbJUdAYf0jtdb8
fec0Zam8Q30YUorBBMJZnTjKkrTHIuA/GeqcqBDp3ecAUvA9s0NfjhNdWaU6KzqC
7Y0FV3uMnQlmvFzrj8ZwebK0Zy7ToRb/faWjWN3vei9dNf9j3aLiZshWHdAYYsN+
jQctWxgBaUsloImzu6plYUn4+OFNcAxIK2gR+OTMDpbYyhpvHb5+g+CAjjnHI7ps
q6GGk01i97Q5ldiG/rYCT+r8JuFvyh4QdcD7gpQkMehPL4s8r5FKhNVJm5NxddMF
oQop8MydELwsk8lM6m/Y4GEifFnyGVhglij0EuPhWNj4N+t3+fw=
=kf85
-----END PGP SIGNATURE-----

--nextPart2373697.kK5g5fdpHx--



