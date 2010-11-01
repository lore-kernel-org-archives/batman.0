Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 1 Nov 2010 12:26:20 +0100
References: <1288450858-14753-1-git-send-email-sven.eckelmann@gmx.de>
	<1288450858-14753-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1288450858-14753-3-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201011011226.21697.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/6] batctl: Remove unused variables
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

On Saturday 30 October 2010 17:00:55 Sven Eckelmann wrote:
> -static void dump_arp(unsigned char *packet_buff, ssize_t buff_len, int
> time_printed) +static void dump_arp(unsigned char *packet_buff, ssize_t
> buff_len) {
>         struct ether_arp *arphdr;
>  
>         LEN_CHECK((size_t)buff_len, sizeof(struct ether_arp), "ARP");
>  
> -       if (!time_printed)
> -               time_printed = print_time();
> -
>         arphdr = (struct ether_arp *)packet_buff;
>  
>         switch (ntohs(arphdr->arp_op)) {
> @@ -111,7 +108,7 @@ static void dump_arp(unsigned char *packet_buff,
> ssize_t buff_len, int time_prin }
>  }

I don't understand why you want to remove the time_printed stuff. Maybe it is 
not so clear what this is good for ? At the beginning of each line batctl 
tcpdump prints a timestamp by caling print_time(). The various functions to 
analyze the headers (e.g. ARP) can be called under different conditions: Either 
after the encapsulating batman-adv header had been printed (including the 
timestamp) or without any prior prints in which case we want to output the 
timestamp.

Regards,
Marek
