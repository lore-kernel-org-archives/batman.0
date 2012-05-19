Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 19 May 2012 14:11:42 +0800
References: <1337267913-14693-1-git-send-email-sven@narfation.org>
In-Reply-To: <1337267913-14693-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205191411.42626.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Revert Distributed ARP Table
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

On Thursday, May 17, 2012 23:18:33 Sven Eckelmann wrote:
> David S. Miller did not like the idea of batman-adv modifying and reading
> the ARP table and refused to pull this feature. It has to be rewritten
> after an acceptable solution was found.
> 
> This reverts following commits:
>  * batman-adv: add UNICAST_4ADDR packet type
>  * batman-adv: add a new log level for DAT debugging
>  * batman-adv: Distributed ARP Table - create DHT helper functions
>  * batman-adv: Distributed ARP Table - add ARP parsing functions
>  * batman-adv: Distributed ARP Table - add snooping functions for ARP
> messages * batman-adv: Distributed ARP Table - increase default soft_iface
> ARP table timeout * batman-adv: Distributed ARP Table - add compile option

Applied in revision d5a6caf.

Thanks,
Marek
