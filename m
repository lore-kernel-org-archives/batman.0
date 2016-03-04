Return-Path: <andrew@lunn.ch>
Date: Fri, 4 Mar 2016 17:21:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160304162144.GW15541@lunn.ch>
References: <20160304152132.GV15541@lunn.ch>
 <2378940.op5bKN67gL@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2378940.op5bKN67gL@sven-edge>
Subject: Re: [B.A.T.M.A.N.] Use of ref_get_unless_zero() ?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

> But you have something which needs to be fixed (you see a crash). Question is 
> what is causing the crash and what can be done against it.

First off, this is 2016.0. There has been some changes in this area
after that release.

The crash itself is happening in batadv_if_ogm_queue_add(). I don't
have an exact matching .lst file for the binary, but:

00000a70 <batadv_iv_ogm_queue_add>:
                                    unsigned char *packet_buff,
                                    int packet_len,
                                    struct batadv_hard_iface *if_incoming,
                                    struct batadv_hard_iface *if_outgoing,
                                    int own_packet, unsigned long send_time)
{
     a70:       55                      push   %ebp
     a71:       89 e5                   mov    %esp,%ebp
     a73:       57                      push   %edi
     a74:       56                      push   %esi
     a75:       89 c6                   mov    %eax,%esi
     a77:       53                      push   %ebx
     a78:       83 ec 34                sub    $0x34,%esp
     a7b:       89 55 e8                mov    %edx,-0x18(%ebp)
     a7e:       89 4d e4                mov    %ecx,-0x1c(%ebp)
        struct batadv_ogm_packet *batadv_ogm_packet;
        bool direct_link;
        unsigned long max_aggregation_jiffies;

        batadv_ogm_packet = (struct batadv_ogm_packet *)packet_buff;
        direct_link = batadv_ogm_packet->flags & BATADV_DIRECTLINK ? 1 : 0;

I think it is this deference of batadv_ogm_packet->flags which is
going wrong. I also don't have a good opps dump. I'm on an intel,
without a serial port, just a VGA, and it is a recursive fault, and
the first Opps has scrolled off the top...

> I am currently 
> wondering how the if_incoming interface is being protected.

I do think it is the if_incoming. The call stack is

batadv_send_outstanding_bat_ogm_packet()
batadv_schedule_bat_ogm()
batadv_tvlv_container_ogm_append()
batadv_iv_ogm_queue_add()

so we have

void batadv_send_outstanding_bat_ogm_packet(struct work_struct *work)
{
...
       /* we have to have at least one packet in the queue to determine the
         * queues wake up time unless we are shutting down.
         *
         * only re-schedule if this is the "original" copy, e.g. the OGM of the
         * primary interface should only be rescheduled once per period, but
         * this function will be called for the forw_packet instances of the
         * other secondary interfaces as well.
         */
        if (forw_packet->own &&
            forw_packet->if_incoming == forw_packet->if_outgoing)
                batadv_schedule_bat_ogm(forw_packet->if_incoming);

I will try to reproduce this with the latest code.

  Andrew
