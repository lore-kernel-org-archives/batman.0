Return-Path: <fboehm@aon.at>
Message-ID: <4BC2CB9E.4050309@aon.at>
Date: Mon, 12 Apr 2010 09:28:30 +0200
From: =?ISO-8859-15?Q?Franz_B=F6hm?= <fboehm@aon.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Patch batman-adv for kernel 2.6.15
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

I am trying to get batman-adv (kernelland) running on Ubiquiti Networks 
hardware. Unfortunately the Ubiquiti SDK uses kernel 2.6.15 and 
batman-adv needs at least 2.6.20. I did have some success in patching 
and running batman-adv-kernelland 0.1 (r1176). I would of course prefer 
using batman-adv 0.2 but I do have problems implementing the older 
kernel workqueue API.

Perhaps someone can give me a hint on porting for example this function 
from send.c to the old workqueue API.

void send_outstanding_bat_packet(struct work_struct *work)
{
    struct delayed_work *delayed_work =
        container_of(work, struct delayed_work, work);
    struct forw_packet *forw_packet =
        container_of(delayed_work, struct forw_packet, delayed_work);
    unsigned long flags;

    spin_lock_irqsave(&forw_bat_list_lock, flags);
    hlist_del(&forw_packet->list);
    spin_unlock_irqrestore(&forw_bat_list_lock, flags);

    send_packet(forw_packet);

    /**
     * we have to have at least one packet in the queue
     * to determine the queues wake up time unless we are
     * shutting down
     */
    if ((forw_packet->own) &&
        (atomic_read(&module_state) != MODULE_DEACTIVATING))
        schedule_own_packet(forw_packet->if_incoming);

    forw_packet_free(forw_packet);
}

Kind regards,
Franz
