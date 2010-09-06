Return-Path: <linus.luessing@web.de>
Date: Mon, 6 Sep 2010 14:37:45 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100906123745.GB13669@Sellars>
References: <1283729393-13842-1-git-send-email-linus.luessing@web.de>
	<20100906073046.GA6973@sven-atom.lazhur.ath.cx>
	<20100906100913.GA13044@Sellars>
	<201009061407.59606.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201009061407.59606.sven.eckelmann@gmx.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Always synchronize rcu's on
 module shutdown
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

> So I would ack the patch with a minor change in the commit message. So instead 
> of
> 
> > During the module shutdown procedure in batman_exit(), a rcu callback is
> > being scheduled (batman_exit -> hardif_remove_interfaces ->
> > hardif_remove_interfae -> call_rcu). However, when the kernel unloads
> > the module, the rcu callback might not have been executed yet, resulting
> > in a "unable to handle kernel paging request" in __rcu_process_callback
> > afterwards, causing the kernel to freeze.
> > Therefore, we should always flush all rcu callback functions scheduled
> > during the shutdown procedure.
> 
> something like
> 
> > During the module shutdown procedure in batman_exit(), a rcu callback is                                                                                                                                  
> > being scheduled (batman_exit -> hardif_remove_interfaces ->                                                                                                                                               
> > hardif_remove_interfae -> call_rcu). However, when the kernel unloads                                                                                                                                     
> > the module, the rcu callback might not have been executed yet, resulting                                                                                                                                  
> > in a "unable to handle kernel paging request" in __rcu_process_callback                                                                                                                                   
> > afterwards, causing the kernel to freeze.                                                                                                                                                                 
>                                                                                                                                                                                                           
> > The synchronize_net and synchronize_rcu in mesh_free are currently                                                                                                                                        
> > called before the call_rcu in hardif_remove_interface and have no real                                                                                                                                    
> > effect on it.                                                                                                                                                                                             
>                                                                                                                                                                                                           
> > Therefore, we should always flush all rcu callback functions scheduled                                                                                                                                    
> > during the shutdown procedure using synchronize_net. The call to                                                                                                                                          
> > synchronize_rcu can be omitted because synchronize_net already calls it.

Yep, sounds good :). Thanks for reviewing and the info about
synchronize_net.

Cheers, Linus

> 
> thanks,
> 	Sven


