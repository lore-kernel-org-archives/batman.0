Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2 2/2] batctl: Add JSON debug commands
Date: Mon, 10 May 2021 16:22:21 +0200
Message-ID: <2573355.sAYfyd1srq@ripper>
In-Reply-To: <8402068.deHtlMXeMU@ripper>
References: <62326514.53yIySlcTU@sven-l14> <20210510075826.12523.26721@diktynna.open-mesh.org> <8402068.deHtlMXeMU@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2360567.FcV7eagA4t"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: asarmanow@gmail.com

 
--nextPart2360567.FcV7eagA4t
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: asarmanow@gmail.com
Subject: Re: [PATCH v2 2/2] batctl: Add JSON debug commands
Date: Mon, 10 May 2021 16:22:21 +0200
Message-ID: <2573355.sAYfyd1srq@ripper>
In-Reply-To: <8402068.deHtlMXeMU@ripper>
References: <62326514.53yIySlcTU@sven-l14> <20210510075826.12523.26721@diktynna.open-mesh.org> <8402068.deHtlMXeMU@ripper>

On Monday, 10 May 2021 12:14:10 CEST Sven Eckelmann wrote:
>     void sanitize_string(const char *str)
>     {
>            while (*str) {
>                    if (*str == '"')
>                            puts("\"");
>                    else if (*str == '\\')
>                            puts("\\\\");
>                    else if (!isprint(*str))
>                            printf("\\x%02x", *str);
>                    else
>                            putc(*str);
> 
>                    str++;
>           }
>    }

Should have tested this. It should be more like:

    void sanitize_string(const char *str)
    {
    	while (*str) {
    		if (*str == '"' || *str == '\\') {
    			putchar('\\');
    			putchar(*str);
    		} else if (!isprint(*str)) {
    			printf("\\x%02x", *str);
    		} else {
    			putchar(*str);
    		}
    	}
    }

Kind regards,
	Sven
--nextPart2360567.FcV7eagA4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmCZQZ0ACgkQXYcKB8Em
e0ZgThAAioRAb6Wk4Idf9nQ+2AUaEacMfafOIn/haui0XgAiacDm5y7F36xmEFzy
gCLu3yxf2ZTmA9w5SO17RyMSvn9RFWMNImRulGe3xVxhCquE2Tky3y8SrLgC9Lv/
j9W5qz/CxS1rz09v8ee64HR32qfHuhC4+MaiMXKnc0Q9SV4/eHBdXPLQdvnJlEP6
TR5Q8dSDOLLQSaMYt5R1hK1si+ShgpaNJRHuwlHAHBp32+DrKdP0WZiTxramNQTB
YRaakLW0dX4FRRJAsikn75rMZryZHD+z/vmFIdmqbO4MzGFqqsKgcRnJm/1bK3s2
23TjoU5Wrzd2Or8RzAcAUkWXjYw5rCo84SIzUTsw5xhy44dctteaDj1LuADuQLMT
q5he1q0VWV+htSZ8xrUtDRT0rNzWgfXFLT0kwZ4sIM3lSpJFggf9XLLhVxyeS/AW
w5eEVZifDs9XDJF5WxtBQN5CUR3c26kf39xujklVurOvkt/GiXUYO/kAHsx6bTpW
n7rL2l0uqYmyiDKZvzYL+2XDp1TJaCbs9ICTtXOaze5S1hV08uX4HdHYX+8aZXiW
td9Dwy16Dnk38rJaJZuhAQmNm+2kjyAXUNegeWLgRGsMGsyBbO8P0k1QsR8ncc+J
uAMCyO2XPfrZT9F+I5tIoNQ9bfEs5xoivJO+XG8AQvbZR1YbWNA=
=C8Rr
-----END PGP SIGNATURE-----

--nextPart2360567.FcV7eagA4t--


