Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 30 Jun 2012 12:01:25 +0200
References: <1340785387-3821-1-git-send-email-ordex@autistici.org>
	<1340785387-3821-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1340785387-3821-4-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206301201.25953.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: detect not yet
	announced clients
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wednesday, June 27, 2012 10:23:06 Antonio Quartulli wrote:
> @@ -43,6 +43,10 @@
>  #define BATADV_PURGE_TIMEOUT 200000 /* 200 seconds */
>  #define BATADV_TT_LOCAL_TIMEOUT 3600000 /* in miliseconds */
>  #define BATADV_TT_CLIENT_ROAM_TIMEOUT 600000 /* in miliseconds */
> +/* Used to compute the timeout value for the entries marked with
> TT_CLIENT_TEMP: + * temp_timeout_value = temp_timeout_fact * orig_int
> + */
> +#define BATADV_TT_CLIENT_TEMP_TIMEOUT_FACT 10UL

You implictely assume that all nodes have the originator interval which might 
not be the case. As soon as they are different this will horribly fail.

Why not using the originator sequence number instead ? It will give you a time 
independent timeout. You could say if we haven't received a TT ADD 3 sequence 
numbers after we added the temporary client is gets merged.

Regards,
Marek
