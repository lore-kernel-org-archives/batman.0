Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 7 Oct 2012 03:36:23 +0800
References: <1349551832-22283-1-git-send-email-ordex@autistici.org>
 <1349551832-22283-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1349551832-22283-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210070336.23832.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/3] batctl: add support for the DAT
	log level
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

On Sunday, October 07, 2012 03:30:31 Antonio Quartulli wrote:
> @@ -327,6 +330,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
>                "messages related to translation table operations", "tt");
>         printf("[%c] %s (%s)\n", (log_level & BIT(3)) ? 'x' : ' ',
>                "messages related to bridge loop avoidance", "bla");
> +       printf("[%c] %s (%s)\n", (log_level & 16) ? 'x' : ' ',
> +              "messages related to arp snooping and distributetd arp table", "dat");
>  
>  out:
>         free(path_buff);

How about using BIT(4) like in the rest of the patch ?

Cheers,
Marek
