Return-Path: <xbing6@gmail.com>
Reply-To: xbing6@gmail.com
From: Xuebing Wang <xbing6@gmail.com>
Subject: Any suggestions about configuring batman-adv gateways + modems
Message-ID: <8b190923-5db5-17b2-da46-538b377d862a@gmail.com>
Date: Mon, 11 Nov 2019 09:32:13 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
To: mareklindner@neomailbox.ch, b.a.t.m.a.n@lists.open-mesh.org

Hi Marek,

Thank you very much for your help.

 >> When modem at gateway (for WAN uplink) is down and loses internet
 >> connection (but batman-adv connections with clients are good and dhcp
 >> server works good), can batman-adv clients know that internet 
connection is
 >> lost and "roam" to another gateway with good internet connection?
 >
 >Seems you are looking for this:
 >https://www.open-mesh.org/projects/batman-adv/wiki/Gateways

Yes, batman-adv gateway is what I am using.

Do I need to write or find a daemon at gateway to sense internet 
connection, once internet connection is lost (and does not recover 
within like 2-5 minutes) then advertise batman-adv mesh network by 
"batctl gw_mode client" to turn this node to be a client?

Thanks.
Xuebing Wang

