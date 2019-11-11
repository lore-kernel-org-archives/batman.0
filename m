Return-Path: <xbing6@gmail.com>
Reply-To: xbing6@gmail.com
From: Xuebing Wang <xbing6@gmail.com>
Subject: Any suggestions about configuring batman-adv gateways + modems
Message-ID: <17dae71f-1ff8-a6c9-c2e5-fec78db34b29@gmail.com>
Date: Mon, 11 Nov 2019 08:52:03 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, mareklindner@neomailbox.ch

Hi Marek,

Thank you for your help, as I did not subscribe to the mailing list, I 
did not get your reply. I subscribe to the mailing list now and I am 
writing a new email thread.


 >> We have been building openwrt 15.05 + batman-adv mesh network for over 2
 >> years, they work great.
 >
 >hopefully, the batman-adv version you are using is newer than 15.05 ...
 >
 >
 >> 1) My first thought is to use batman-adv gateway (with 4G modem
 >> connected) as dhcp server, and forward batman-adv interface to wan
 >> interface (modem).
 >>
 >> 1.1)  But, there is an issue with this setup. Once a modem is down,
 >> nodes that are connected to this batman-adv gateway (with modem) can not
 >> automatically "roam" to another batman-adv gateway (with good modem
 >> connection).
 >
 >Why not ? What should prevent nodes or clients to choose another 
batman-adv
 >gateway ?

When modem (for WAN uplink) at gateway is down and loses internet 
connection (but batman-adv connections with clients are good and dhcp 
server works good), can batman-adv clients know that internet connection 
at gateway is lost and "roam" to another gateway with good internet 
connection?

Thanks.
Xuebing Wang

