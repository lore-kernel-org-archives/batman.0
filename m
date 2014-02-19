Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 19 Feb 2014 15:21:54 +0800
Message-ID: <3768164.qYOYKYLPuX@diderot>
In-Reply-To: <1392732804-23206-1-git-send-email-sw@simonwunderlich.de>
References: <1392732804-23206-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart21106802.Snnc99dpM9";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: add option for multiif orig table
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


--nextPart21106802.Snnc99dpM9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 18 February 2014 15:13:24 Simon Wunderlich wrote:
> @@ -162,7 +175,10 @@ int handle_debug_table(char *mesh_iface, int
> debug_table, int argc, char **argv) return EXIT_FAILURE;
>         }
>  
> -       debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface, full_path,
> sizeof(full_path)); +       if (orig_iface)
> +               debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", orig_iface,
> full_path, sizeof(full_path)); +       else
> +               debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface,
> full_path, sizeof(full_path)); return read_file(full_path, (char
> *)batctl_debug_tables[debug_table].debugfs_name, read_opt, orig_timeout,
> watch_interval,
>                          batctl_debug_tables[debug_table].header_lines);

While playing with your patch I noticed a couple of things:

 * 'batctl originators -i eth0' is equivalent to 'batctl -m eth0 originators'
 * the latter works even without your patch
 * the orig table output does not say which interface we are looking at but 
always reports: (bat0 BATMAN_IV)
 * /sys/kernel/debug/batman_adv/ contains all sorts of hard-interfaces on my 
test setup even if they are not used by batman-adv - is the intended ?


Cheers,
Marek

--nextPart21106802.Snnc99dpM9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTBFuWAAoJEFNVTo/uthzA7lkH/RluCC71OSABpKr4paXy7ZZd
kptZqIuN/l7qE8X/jA+oF3WjI63ewB0rjVW0avmpvpqmxei32c56gpPV2zVDpTc0
m6+SBgyb10BxVnYq+ywUUGYS1ADCv/JOm817lXAqxU9Ebf7sZ77HV4wraaaMM2C0
1E70xsnR4d8xX/Cuoz0KydinMBNJ8R5KrZNwVRbJkMQ1OV7gEQ+bQZVu4AWnEqPV
0jTyy/lJjoddYztCJiLUhXc+ENyTjkp1DArgfalmUMpxc7TUeSCxgev2s1RjUU/G
U9OXie1iKIergRX8b7X6YQUVXbwkTr1R/6jrGqcZYirK3mRRubxD7g9LHMft1IE=
=rCvM
-----END PGP SIGNATURE-----

--nextPart21106802.Snnc99dpM9--

