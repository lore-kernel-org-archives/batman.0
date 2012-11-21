Return-Path: <lmy19901031@gmail.com>
MIME-Version: 1.0
Date: Wed, 21 Nov 2012 16:13:28 -0500
Message-ID: <CALDpWg5uMQzHkJeOiFAY4nF1OPS_d_47QPKJs5v2NheBmKP_8A@mail.gmail.com>
From: liu muye <lmy19901031@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] [B.A.T.M.A.N] batman-adv : client to client
	communication
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
To: b.a.t.m.a.n@lists.open-mesh.org

Thank you so much for your suggestions. Yes, we are using batman-adv.
The one running as a kernel module.
Just a few quick follow up questions.

Our goal is to build an ad hoc mesh network. Each node may not have IP
address. I can use batctl ping functionality to ping my peer with MAC
address. Just wondering if I can send data packet to my peers with MAC
address.

I have noticed the packet.h file in the batctl source code contains
several C structures. One of  them is

struct batadv_unicast_packet {
    struct batadv_header header;
    uint8_t  ttvn; /* destination translation table version number */
    uint8_t  dest[ETH_ALEN];
} __packed;

To send my data packet, I have to use this C structure. Is that
correct? and where to look up the value for ttvn?

Thanks for your time
Have a nice day
