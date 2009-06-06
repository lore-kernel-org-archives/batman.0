Message-ID: <970038.10769.qm@web55307.mail.re4.yahoo.com>
Date: Sat, 6 Jun 2009 06:04:56 -0700 (PDT)
From: austinxxh-ath9k@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [B.A.T.M.A.N.] ath9k and batman-adv
Reply-To: austinxxh-ath9k@yahoo.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: b.a.t.m.a.n@open-mesh.net


ok it works now. i had to change "ath0" to "wlan1" at /etc/config/batman-adv.

thanks!
xxiao

--- On Fri, 6/5/09, austinxxh-ath9k@yahoo.com <austinxxh-ath9k@yahoo.com> wrote:

> From: austinxxh-ath9k@yahoo.com <austinxxh-ath9k@yahoo.com>
> Subject: [B.A.T.M.A.N.] ath9k and batman-adv
> To: b.a.t.m.a.n@open-mesh.net
> Date: Friday, June 5, 2009, 11:05 PM
> 
> I'm trying to use batman-adv with ath9k/openwrt. two
> boards(each board has one ath9k card and one ath5k card),
> ath9k on both boards are configured at the same channel(5),
> then I did :
> #echo wlan1 > /proc/net/batman-adv/interfaces
> on each of the board, however
> #cat /proc/net/batman-adv/originators
> showed up nothing.
> 
> Note: I have wlan0 with ath5k for AP, on different
> channels. I also have eth0 with local IP address but I did
> not add it to batman-adv.
> 
> I then tried to configure bat0 with IP address and then
> ping, of course it did not work.
> 
> anything else that I am missing here? anyone had success
> with ath9k/batman-adv?
> 
> thanks!
> xxiao
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> 
