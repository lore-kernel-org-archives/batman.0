Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2 2/2] batctl: Add JSON debug commands
Date: Mon, 10 May 2021 12:14:10 +0200
Message-ID: <8402068.deHtlMXeMU@ripper>
In-Reply-To: <20210510075826.12523.26721@diktynna.open-mesh.org>
References: <62326514.53yIySlcTU@sven-l14> <20210510075826.12523.26721@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7207813.odcMes2e8k"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: asarmanow@gmail.com

 
--nextPart7207813.odcMes2e8k
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: asarmanow@gmail.com
Subject: Re: [PATCH v2 2/2] batctl: Add JSON debug commands
Date: Mon, 10 May 2021 12:14:10 +0200
Message-ID: <8402068.deHtlMXeMU@ripper>
In-Reply-To: <20210510075826.12523.26721@diktynna.open-mesh.org>
References: <62326514.53yIySlcTU@sven-l14> <20210510075826.12523.26721@diktynna.open-mesh.org>

On Monday, 10 May 2021 09:58:26 CEST asarmanow@gmail.com wrote:
> Sven Eckelmann wrote:
> 
> > Why are you only printing selected attributes and not all?
> I wanted to reduce the amount to query for the netlink_print_json_entries function. There are only a few of the attributes needed for each of the JSON commands. 

You are doing currently two queries (one BATADV_CMD_GET_MESH_INFO and one for 
the actual data). I want to you to get rid of the BATADV_CMD_GET_MESH_INFO and 
print all data which was returned for the actual data query.

So I don't see a reason why you're approach would help here at all. Just go 
with netlink_print_json_entries through all entries in attrs till 
BATADV_ATTR_MAX and check if you have a function to print them. If you have, 
just print it.

You can then also get rid of missing_mandatory_attrs and also extra checks 
like MULTICAST_ONLY/UNICAST_ONLY/NO_OLD_ORIGS. The json is not for human 
consumption and thus we don't need special flags to prefilter the data. The 
consumer can take care of processing the data.

Btw. I am also more of a fan of following style of struct/array 
initialization. 

    struct nla_policy_json batadv_netlink_policy_json[NUM_BATADV_ATTR] = {
    	[BATADV_ATTR_VERSION] = {
    		.name = "version",
    		.cb = nljson_print_str
    	},
    	[.....]

I have to change this at some point in netlink.c

> +void create_json_print_string(const char *str, const char **str_ret)
> +{
> +       size_t needed = snprintf(NULL, 0, "\"%s\"", str);
> +       char  *str_buf = malloc(needed+1);
> +
> +       sprintf(str_buf, "\"%s\"", str);
> +
> +       *str_ret = str_buf;
> +}

Another thing I saw: you allocate a lot of strings but never free them. Can we 
just avoid to allocate them?

Other than that - why? This function doesn't make a lot of sense in the first 
place.

> +       [BATADV_ATTR_FLAG_BEST]                 = { .name = "best",
> +                                                   .cb = nljson_print_bool},


Also: BATADV_ATTR_FLAG_BEST is not a boolean - it is a flag. So it can be 
present and absent. So is comparable to an HTML attribute without value (for 
example "disabled"). I think we can encode it as "best": true when it exists.

> +void nljson_print_ttflags(struct json_opts *json_opts, struct print_opts *opts,
> +                         struct nlattr *attrs[], int idx)
> +{
> +       const char *key_ls;
> +       uint32_t flags;
> +       char r, n, x, w, i, p, t;
> +
> +       flags = nla_get_u32(attrs[idx]);
> +
> +       r = '.', p = '.', n = '.', x = '.', w = '.', i = '.', t = '.';
> +
> +       if (opts->nl_cmd == BATADV_CMD_GET_TRANSTABLE_LOCAL) {
[...]
> +       } else {
> +               if (flags & BATADV_TT_CLIENT_ROAM)
> +                       r = 'R';
> +               if (flags & BATADV_TT_CLIENT_WIFI)
> +                       w = 'W';
> +               if (flags & BATADV_TT_CLIENT_ISOLA)
> +                       i = 'I';
> +               if (flags & BATADV_TT_CLIENT_TEMP)
> +                       t = 'T';
> +
> +               goto print_global_table;
> +       }
> +
> +print_local_table:
> +       printf("\"%c%c%c%c%c%c\"", r, n, x, w, i, p);
> +
> +       printf(",");
> +       create_json_print_string(batadv_netlink_policy_json[BATADV_ATTR_LAST_SEEN_MSECS].name,
> +                                &key_ls);
> +       sanitize_string(key_ls, strlen(key_ls));
> +       printf(":");
> +       nljson_print_int(json_opts, opts, attrs, BATADV_ATTR_LAST_SEEN_MSECS);
> +
> +       return;
> +
> +print_global_table:
> +       printf("\"%c%c%c%c\"", r, w, i, t);
> +}



nljson_print_ttflags is also odd. If you decode the binary, why are you 
creating a compact representation again? Why aren't you just create a sub 
object with the parsed data? And there is no need to differentiate between 
BATADV_CMD_GET_TRANSTABLE_LOCAL and BATADV_CMD_GET_TRANSTABLE_GLOBAL.

And why is there a goto in the first place at the end of each scope?


And you interpretation of BATADV_ATTR_LAST_SEEN_MSECS seems to be really 
messed up. Just don't print BATADV_ATTR_LAST_SEEN_MSECS when it is not there - 
which can be evaluated automatically. And just as info: the kernel will not 
send it when the nopurge bit is set. So it is absolutely not what you've 
coded here.

> +void nljson_print_crc32(struct json_opts *json_opts, struct print_opts *opts,
> +                     struct nlattr *attrs[], int idx)
> +{
> +       (void) json_opts;
> +       (void) opts;
> +       int32_t value = nla_get_u32(attrs[idx]);
> +       printf("\"0x%.8x\"", value);
> +}

Can we just print the raw 32 bit unsigned integer?

Also, please not the name but the actual number in places were you are now 
calling nljson_print_ifname_by_ifindex. Otherwise you would print the name 
twice and make unnecessary syscalls. And if you want to print the actual name 
for things like the originator/neighbor dump, maybe just add it to the generic 
netlink message in the kernel.


> +void netlink_print_json_entries(struct nlattr *attrs[], int selected_attrs[],
> +                               int arr_len, struct print_opts *opts)
> +{
> +       const char *name;
> +       uint8_t first_valid_attr = 1;
> +       int idx, i;
> +       struct json_opts json_opts = {
> +               .use_alt_int_val = 0,
> +               .alt_int_val = 0,
> +       };
> +
> +
> +       if (!opts->is_first)
> +               printf(",");
> +
> +       for (i = 0; i < arr_len; i++) {
> +               idx = selected_attrs[i];
> +
> +               if (attrs[idx] && batadv_netlink_policy_json[idx].cb) {
> +                       if (!first_valid_attr)
> +                               printf(",");
> +                       else
> +                               printf("{");
> +
> +                       create_json_print_string(batadv_netlink_policy_json[idx].name,
> +                                                &name);
> +                       sanitize_string(name, strlen(name));
> +                       printf(":");
> +                       batadv_netlink_policy_json[idx].cb(&json_opts, opts,
> +                                                          attrs, idx);
> +
> +                       first_valid_attr = 0;
> +               }
> +       }
> +       if (!first_valid_attr)
> +               printf("}");
> +}


Why aren't you handling the is_first = 0 in this function? And why aren't you 
printing empty objects?

And please try to handle rejections and not acceptance. So instead of:

           for (i = 0; i < arr_len; i++) {
                   idx = selected_attrs[i];
    
                   if (attrs[idx] && batadv_netlink_policy_json[idx].cb) {

Maybe something like:

           for (i = 0; i < arr_len; i++) {
                   [...]    
                   if (!attrs[idx])
                        continue;
    
                   if (!batadv_netlink_policy_json[idx].cb)
                        continue;

> +void sanitize_string(const char *str, int str_len)
> +{
> +       int i;
> +
> +       for (i = 0; i < str_len; i++) {
> +               if (str[i] == '"')
> +                       printf("\"");
> +               else if (str[i] == '\\')
> +                       printf("\\\\");
> +               else if (!isprint(str[i]))
> +                       printf("\\x%02x", str[i]);
> +               else
> +                       printf("%c", str[i]);
> +       }
> +}

I know, it is the similar in alfred but maybe you can change it to something 
like:

    void sanitize_string(const char *str)
    {
           while (*str) {
                   if (*str == '"')
                           puts("\"");
                   else if (*str == '\\')
                           puts("\\\\");
                   else if (!isprint(*str))
                           printf("\\x%02x", *str);
                   else
                           putc(*str);

                   str++;
          }
   }

> +static int meshinfo_callback(struct nl_msg *msg, void *arg)
> {
[...]
> +       int selected_attrs[10] = { BATADV_ATTR_MESH_IFNAME,
> +                                  BATADV_ATTR_MESH_ADDRESS,
> +                                  BATADV_ATTR_HARD_IFNAME,
> +                                  BATADV_ATTR_VERSION,
> +                                  BATADV_ATTR_ALGO_NAME,
> +                                  BATADV_ATTR_HARD_ADDRESS,
> +                                  BATADV_ATTR_TT_TTVN };

I hope to get rid of this anyway but this should have been:

	static const enum batadv_nl_attrs selected_attrs[] = {
		BATADV_ATTR_MESH_IFNAME,
		BATADV_ATTR_MESH_ADDRESS,
		BATADV_ATTR_HARD_IFNAME,
		BATADV_ATTR_VERSION,
		BATADV_ATTR_ALGO_NAME,
		BATADV_ATTR_HARD_ADDRESS,
		BATADV_ATTR_TT_TTVN,
	}

So no hardcoded (and wrong) length, correct type, constant, not allocated on 
the stack, different identation.


> +static int netlink_print_meshinfo_json(struct state *state, char *orig_iface,
> +                                      int read_opts, float orig_timeout,
> +                                      float watch_interval)
> +{
> +       (void) orig_iface;
> +       (void) orig_timeout;
> +       (void) watch_interval;
> +               (void) read_opts;

Please annotate unused parameters correctly with __maybe_unused

Also use the already existing netlink socket and don't create a new one. Maybe 
even with sys_simple_nlquery.
Most functionality which creates its own batadv generic netlink socket only 
does it because it needed to support the old sysfs functionality in parallel 
in the past. And no on found the time to clean this up after the sysfs stuff 
was dropped.

If we don't need the "fancy" features of the debug tables then we can also use 
the functionality sys_simple_nlquery for the rest. At least we don't have
the bat-host handling anymore, header is dropped and the filter might be 
dropped. And the only reason why I was against the special code to prevent
the "watch" functionality was that we need to introduce a new hack for it.

Just make sure that you allow the caller to change the 6th parameter of 
genlmsg_put. Maybe by introducing a new function which allows to set this 
parameter. And the sys_simple_nlquery is changed to a wrapper which omits the 
new "flags" parameter.

And then you can also add the putc for '[' and ']' directly to the caller of 
sys_simple_nlquery (or whatever the new function will be called).

> +#define BOOL_STRING(x) (x ? "true" : "false")
> +

I don't see a lot of benefit in this macro.

> + * Andrew Lunn <andrew(a)lunn.ch&gt;
> + * Sven Eckelmann <sven(a)narfation.org&gt;
> + * Alexander Sarmanow <asarmanow(a)gmail.com&gt;

No fancy html tags in headers please.



Overall: please run you patches through Linux's scripts/checkpatch.pl --strict 
and check what of the things you see is only relevant for the kernel and what 
might be actual things you should clean up.


> +       [BATADV_ATTR_MESH_IFNAME]               = { .name = "mesh_if",
> +                                                   .cb = nljson_print_str },
> +       [BATADV_ATTR_MESH_ADDRESS]              = { .name = "mesh_address",
> +                                                   .cb = nljson_print_mac},
> +       [BATADV_ATTR_ORIG_ADDRESS]              = { .name = "originator",
> +                                                   .cb = nljson_print_mac },


Please keep the same order as the attributes in batman_adv.h


Missing print functions:

* BATADV_ATTR_TPMETER_RESULT
* BATADV_ATTR_TPMETER_TEST_TIME
* BATADV_ATTR_TPMETER_BYTES
* BATADV_ATTR_TPMETER_COOKIE
* BATADV_ATTR_ACTIVE
* BATADV_ATTR_BANDWIDTH_UP
* BATADV_ATTR_BANDWIDTH_DOWN
* BATADV_ATTR_ROUTER
* BATADV_ATTR_BLA_OWN
* BATADV_ATTR_BLA_ADDRESS
* BATADV_ATTR_BLA_VID
* BATADV_ATTR_BLA_BACKBONE
* BATADV_ATTR_DAT_CACHE_IP4ADDRESS
* BATADV_ATTR_DAT_CACHE_HWADDRESS
* BATADV_ATTR_DAT_CACHE_VID
* BATADV_ATTR_MCAST_FLAGS
* BATADV_ATTR_MCAST_FLAGS_PRIV
* BATADV_ATTR_VLANID
* BATADV_ATTR_AGGREGATED_OGMS_ENABLED
* BATADV_ATTR_AP_ISOLATION_ENABLED
* BATADV_ATTR_ISOLATION_MARK
* BATADV_ATTR_ISOLATION_MASK
* BATADV_ATTR_BONDING_ENABLED
* BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED
* BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED
* BATADV_ATTR_FRAGMENTATION_ENABLED
* BATADV_ATTR_GW_BANDWIDTH_DOWN
* BATADV_ATTR_GW_BANDWIDTH_UP
* BATADV_ATTR_GW_MODE
* BATADV_ATTR_GW_SEL_CLASS
* BATADV_ATTR_HOP_PENALTY
* BATADV_ATTR_LOG_LEVEL
* BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED
* BATADV_ATTR_NETWORK_CODING_ENABLED
* BATADV_ATTR_ORIG_INTERVAL
* BATADV_ATTR_ELP_INTERVAL
* BATADV_ATTR_THROUGHPUT_OVERRIDE
* BATADV_ATTR_MULTICAST_FANOUT


> +       [BATADV_ATTR_MESH_IFINDEX]              = { .name = "mesh_if_idx",

meshif_idx or mesh_ifindex

> +       [BATADV_ATTR_MESH_IFNAME]               = { .name = "mesh_if",

meshif or mesh_ifname

> +       [BATADV_ATTR_HARD_IFINDEX]              = { .name = "hard_if_idx",

hardif_idx or hard_ifindex

> +       [BATADV_ATTR_HARD_IFNAME]               = { .name = "hard_if",

hardif or hard_ifname

> +       [BATADV_ATTR_TT_ADDRESS]                = { .name = "client",

why client? It is not really a  client.

tt_address

> +       [BATADV_ATTR_TT_VID]                    = { .name = "vid",

tt_vid

> +       [BATADV_ATTR_TT_FLAGS]                  = { .name = "flags",

tt_flags


> +       [BATADV_ATTR_LAST_SEEN_MSECS]           = { .name = "last_seen",

last_seen_msecs

> +       [BATADV_ATTR_NEIGH_ADDRESS]             = { .name = "neighbor",

neigh_address

> @@ -21,8 +21,22 @@ struct print_opts {
>         float watch_interval;
>         nl_recvmsg_msg_cb_t callback;
>         char *remaining_header;
> +       char *remaining_entry;
>         const char *static_header;
>         uint8_t nl_cmd;
> +       uint8_t is_json;
> +       uint8_t is_first;
> +};

     uint8_t is_json:1
     uint8_t is_first:1

And what is remaining_entry?

Kind regards,
	Sven
--nextPart7207813.odcMes2e8k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmCZB3IACgkQXYcKB8Em
e0bsVhAArkeErtjY9dhl0rjB6HM18JH6p+0LCKoA+t/SrEXAzDgod/21X6oE+pn/
1ymHc8TPWh699X693rg2Lm84LdvEgYS72wx5B7lQFNJ7fWQSzWndFSIm7q4RP0p5
iA9AD5Psf8PrDPQJS0DCteCkQX+ndLrYPHqAdeXOnqn6TLbLFFYHlzisOvo2FYNq
mwJre4Z4/nuaDz26Z+8hDfeetDZj3EcQ4+bKuk9CQmbo3w2VTwUJq+tHciwEy8wG
+xOGMcGHrGC0X5TaTuzq890FpHASB1D7uCISl+ghQrPWsJxnUagHZAkoABZRe3ul
uYiHLXlcQGdMJlXr3sS/41JFNHgNkfn2aKXuv8PSSOqippOTb4+VosQogBjCKLSR
2qGhTlKhFKZ3j3QwPJIwTPL9e+ztL1feZALTmTk9gaU+QK/1NPt5lIpy8kX4+7xy
r4hZsqsB4sjsXx6xzwEdPuW7vjbqoZZ6aovkxFHpp4uULMM3Z6sr5b3UCjyQ4jSW
QjZZN4AJuDn7s1tHzxK/YCt1YTxQWO9OEfE5HAY82JE+JzwdHjBwLG9j/ed4W6pI
A+44J1K0ho6WIpY40Wmlr+S9yGQtPshlPL+Dzng9VzwVCAqLwXS46KR5C1NB7Tzs
Yl8jwZ/qcl5Dl0a4T1Ydx66dXW/C78uT2xEaDOjvwcEi3zQHjkc=
=QIWo
-----END PGP SIGNATURE-----

--nextPart7207813.odcMes2e8k--


