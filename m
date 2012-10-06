Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 7 Oct 2012 03:47:09 +0800
References: <1349552434-6845-1-git-send-email-ordex@autistici.org>
 <1349552434-6845-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1349552434-6845-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210070347.09575.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/3] batctl: add support for the DAT
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

On Sunday, October 07, 2012 03:40:33 Antonio Quartulli wrote:
> @@ -258,6 +258,7 @@ static void log_level_usage(void)
>  	printf(" \t routes  Messages related to route added / changed /
> deleted\n"); printf(" \t tt      Messages related to translation table
> operations\n"); printf(" \t bla     Messages related to bridge loop
> avoidance\n"); +	printf(" \t dat     Messages reated to arp snooping and
> sitributed arp table\n"); }

reated => related
sitributed => distributed


> @@ -327,6 +330,8 @@ int handle_loglevel(char *mesh_iface, int argc, char
> **argv) "messages related to translation table operations", "tt");
> printf("[%c] %s (%s)\n", (log_level & BIT(3)) ? 'x' : ' ',
>  	       "messages related to bridge loop avoidance", "bla");
> +	printf("[%c] %s (%s)\n", (log_level & BIT(4)) ? 'x' : ' ',
> +	       "messages related to arp snooping and distributetd arp table",
> "dat");

distributetd => distributed

You wrote that word too often!  ;)

Cheers,
Marek
