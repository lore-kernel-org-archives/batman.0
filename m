Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 25 Nov 2011 09:18:07 +0800
References: <1322173279-18338-1-git-send-email-ordex@autistici.org>
	<1322173279-18338-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1322173279-18338-6-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201111250918.08125.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 5/7] batman-adv: Distributed ARP Table
	- add snooping functions for ARP messages
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

On Friday, November 25, 2011 06:21:17 Antonio Quartulli wrote:
> @@ -30,6 +31,8 @@
>  #include "originator.h"
>  #include "bat_ogm.h"
>  
> +#include <net/arp.h>
> +
>  static void send_outstanding_bcast_packet(struct work_struct *work);

What is this include doing here ? If I am not mistaken you removed it from 
your patchset already. Is this really the latest version ? 

Regards,
Marek
