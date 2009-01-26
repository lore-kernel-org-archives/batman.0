From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 26 Jan 2009 20:41:31 +0100
References: <238a15490901231630s7d460687x6a95238f7308998a@mail.gmail.com>
	<200901240942.07893.lindner_marek@yahoo.de>
	<238a15490901260934i1f4dcd30u7404cd79fff7a29c@mail.gmail.com>
In-Reply-To: <238a15490901260934i1f4dcd30u7404cd79fff7a29c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200901270341.31896.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Help in batman advanced configuration
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Tuesday 27 January 2009 01:34:16 Gargi Purohit wrote:
> I hope other than setting the interface "ath0" in
> /proc/net/batman-advanced/interfaces - i dont
> need any other configuration changes.
>
> Since I can batping between the two routers i guess the layer 2
> connectivity is established between
> these guys - am just wondering if they should be able to forward
> requests like dhcp over multiple hop
> (1 hop and above)....

Yes, a working batping indicates that the connection between both modules is 
given. The DHCP request should be forwarded without problems. Your setup is 
misconfigured somewhere.

Could you please show the output of "brctl show br0" and "cat 
/proc/net/batman-adv/interfaces" on both nodes. You can check where the dhcp 
request dies by using tcpdump or batdump.

Regards,
Marek

