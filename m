From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 1 May 2009 15:55:43 +0800
References: <4313f3060904300843ra2f7a71o37f39780a797cfd2@mail.gmail.com>
In-Reply-To: <4313f3060904300843ra2f7a71o37f39780a797cfd2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905011556.00288.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] times wrapper
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

Hi,

> When I switched to batman, I saw that times() is used in it as well,
> so I made the patch attached.  So, if anyone sees packets fail to come
> from batman for 40 seconds, they might need this.

excellent finding! I immediately applied your patch.

For the curious reader:
When you develop a daemon that should do certain things in intervals (e.g. 
sending packets, removing dead nodes from the routing table, etc) you will 
need a reference clock to know when this interval is over. Using the system 
time as reference is the obvious solution which theoretically offers what you 
need. 

As often, reality is much harder: time synchronisation approaches (e.g. NTP), 
manually changed system time, winter / summer time switches, timezones, etc 
might encourage the daemon to improvised reactions (e.g. sending the messages 
of the last 3 years because ntp just finished the time sync).

A more stable reference clock can be found by using the times() system call. 
It returns "the number of clock ticks that have elapsed since an arbitrary 
point in the past" (often the uptime). The compelling advantage: it always 
increments although it overflows from time to time. 

Batman uses the times() function which has a bug that this patch deals with. I 
had a short look in the olsr code (0.5.6-r4) to see how this bug is being 
handled there. main.c line 896 reveals a function called olsr_times()

--- SNIP -->
clock_t
olsr_times(void)
{
  struct tms tms_buf;
  return times(&tms_buf);
}
<-- SNAP ---

which is called from vairous places that don't deal with this bug:

scheduler.c line 117
--- SNIP -->
void
olsr_scheduler(void)
{
 [..]
  /* Main scheduler loop */
  for (;;) {

    /*
     * Update the global timestamp. We are using a non-wallclock timer here
     * to avoid any undesired side effects if the system clock changes.
     */
    now_times = olsr_times();

    [..]

    /* We are done, sleep until the next scheduling interval. */
    olsr_scheduler_sleep(olsr_times() - now_times);
<-- SNAP ---

Regards,
Marek

