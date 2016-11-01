Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Nov 2016 22:08:41 +0100
Message-ID: <3174032.jlAuIyjvHM@sven-edge>
In-Reply-To: <b861d75b-1ece-c8d6-a7cf-1b26b2c47bfb@t-online.de>
References: <b861d75b-1ece-c8d6-a7cf-1b26b2c47bfb@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1549965.DSsifxtHFO";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] Alfred not working within network name
	space
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
Cc: Jean-Jacques Sarton <jj.sarton@t-online.de>

--nextPart1549965.DSsifxtHFO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 1. November 2016 20:07:24 CET Jean-Jacques Sarton wrote:
> This patch shall allow to use the debugfs as previouly, including
> the check for valify of the interface used.
> For netns the check seem to be implemented within the function
> netlink_query_common().
> For netlink we check if the originators ans transtable_global
> informations are accessible through netlink.
> 
> To: b.a.t.m.a.n@lists.open-mesh.org
> 
> Signed-off-by: Jean-Jacques Sarton <jj.sarton@t-online.de>

Please fix the subject/summary and write a proper commit message
body [1]. Please remove the odd "To: " in the middle of the commit
message body.

The subject of the mail should start with '[PATCH]' (or '[PATCH v2]'
for the second version of the patch and so on). Then you should add
"alfred: " so we easily spot in patchwork for which project the patch
is. After that, you should add a "oneline summary" of what it is
doing and not the problem like in your "Alfred not working within
network name space".

About the commit message body:

 * "This patch" is a bad start for a commit message
 * The first sentence doesn't make a lot of sense because your
   change should add the interface checks via netlink without using
   debugfs.
 * previouly -> previously
 * What is "valify"?
 * netlink_query_common doesn't check the validity of the interface
   but it can be used to check if this interface supports the netlink
   commands to retrieve the global translation table and the originators
   table
 * ans -> and

Maybe you can describe what is currently wrong and then how it gets fixed.

The mail subject ("oneline summary") without the '[PATCH...]' + the
commit message body (till the first occurence of an '---' line) is
later used to describe the change in git.

[...]
> -int batadv_interface_check(const char *mesh_iface)
> +int batadv_interface_check_debugfs(const char *mesh_iface)
>  {
>  	char full_path[MAX_PATH + 1];
>  	FILE *f;
> @@ -166,6 +166,18 @@ int batadv_interface_check(const char *mesh_iface)
>  	return 0;
>  }

Please mark this function static.

> +int batadv_interface_check(const char *mesh_iface)
> +{
> +	int ret = 0;
> +	enable_net_admin_capability(1);
> +	ret = batadv_interface_check_netlink(mesh_iface);
> +	enable_net_admin_capability(0);
> +
> +	if ( ret < 0 )
> +		return batadv_interface_check_debugfs(mesh_iface);
> +	return 0;
> +}
> +

Please use the same whitespace rules like in the rest of the code [2].
For example a newline after the variables block, no extra spaces
inside the parenthesis and a newline after "return batadv_"...

It is also not required to initialize ret when you overwrite the initial
value later without reading the initial value somewhere.

[...]
> +
> +int batadv_interface_check_netlink(const char *mesh_iface)
> +{
> +	struct get_tq_netlink_opts opts = {
> +		.tq = 0,
> +		.found = false,
> +		.query_opts = {
> +			.err = 0,
> +		},
> +	};
> +	int ret = 0;
> +
> +	memset(&opts.mac, 0, ETH_ALEN);
> +
> +	ret = netlink_query_common(mesh_iface,  BATADV_CMD_GET_ORIGINATORS,
> +			           get_tq_netlink_cb, &opts.query_opts);
> +	if (ret < 0)
> +		return ret;
> +
> +	memset(&opts.mac, 0, ETH_ALEN);
> +	ret = netlink_query_common(mesh_iface, BATADV_CMD_GET_TRANSTABLE_GLOBAL,
> +			           get_tq_netlink_cb, &opts.query_opts);
> +
> +	if (ret < 0)
> +		return ret;
> +	return 0;
> +}

See previous mails and the things mentioned above. It is also odd that you use
sometimes 12 spaces (better use 1 tab + 4 spaces for changes to this project).

Kind regards,
	Sven

[1] https://www.kernel.org/doc/Documentation/SubmittingPatches
[2] We try to use a non-strict version of
    https://www.kernel.org/doc/Documentation/CodingStyle
--nextPart1549965.DSsifxtHFO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYGQRZAAoJEF2HCgfBJntGIaMQAM3NT13iMP9D9xcqsJGbOtzQ
E0vJQahHw2RBZZ8b0hhkizflwLKefbRrcews+fFvCVoU+sbnDdwFRXGy6FMz4lZ6
LTKWaQvl2CfxxFuPCDLdI21rDa1APtOh0H63oL+YBS5laDC1GVa8PnHRMIWIkZeP
lgH1D+7bwhpZOe3Xv/RZklokPdEGOc0yxKeitduS7KU3hmmZJEt0QEDOfmWQfUI4
3FznKeHCzU8SjDAM8hSKaCYWyRY1h4CXgulzc3LpWaD7Afwz2OZAZL6zaFg8XEsM
tlkB3AdEuYYacJsc8vWSNwxEvU/knsGS+k2kasaRCxgG/nimnlUXq7rti2Iiq0FM
OnfKb7tKqDpkBH1NIbJhJBWmj/PLm1W/dZDtsT253bjU5wFYfweCgKYt5+T0dgLe
g2mAO3BMEulHJ100VKQm3BELhBO2LmgQ414BPRSaJhQ5NPuYG2MNpxaePAb1yTg0
WeWG8vKBqXAaMP8QN20Ms2XRouasSeYybeq4f0oKxBIMt0CXeu4I8Kuc2lQExwj2
wTm73phjur2LptveXi+WwnZlH4Lo2vZK+t1rpeuHNp4UvA0mBiMB2MglnxLNJR91
N76+ViWJy2C7WYhYSpyvQDsMhY249oa/tcwHTcEbfNBa1IgMRAZCOfyBE0YKgKXq
ORIflti3CBVfiFN2bway
=OT/Y
-----END PGP SIGNATURE-----

--nextPart1549965.DSsifxtHFO--

