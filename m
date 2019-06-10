Return-Path: <klukonin@gmail.com>
MIME-Version: 1.0
References: <20190609101922.2366-1-treffer@measite.de>
 <3224708.U1DPrJmi8S@rousseau>
 <accc8852-ded3-188b-b72e-313d1b462d18@measite.de>
 <4907494.lMUJSmCnaO@rousseau>
In-Reply-To: <4907494.lMUJSmCnaO@rousseau>
From: =?UTF-8?B?0JrQuNGA0LjQu9C7INCb0YPQutC+0L3QuNC9?= <klukonin@gmail.com>
Date: Mon, 10 Jun 2019 12:37:08 +0500
Message-ID: <CALYz8yoqh8X3hZcafrZAauFT4OZtQZ9r92G+9zW9__ir4m5How@mail.gmail.com>
Subject: Re: [PATCH] batman-adv: Use wifi rx/tx as fallback throughput
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hello, colleagues.

I have a working solution for this problem. It is not batman-related,
but I decided to share it with you right here.
Please let me clarify some  details.

1) Some ath10k firmwares (10.2) do not export tx bitrate. So we can't
rely on it.
2) Throughput estimation is better to inject from userspace, rather
than make batman estimate it from unreliable sources.
3) Here is the patch for mac80211 We made for ath10k and such drivers
that do not export expected throughput value.

I also think it's a better way because a lot of drivers do not work
with mac80211 (wil6210). And all driver-dependent math can be easily
changed on-the-fly.


Here is simple patch that make possible this expected throughput injection.

--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -12,6 +12,7 @@

 #include <linux/debugfs.h>
 #include <linux/ieee80211.h>
+#include <net/mac80211.h>
 #include "ieee80211_i.h"
 #include "debugfs.h"
 #include "debugfs_sta.h"
@@ -20,6 +21,8 @@

 /* sta attributtes */

+#define DEF_THR_BUFF_SIZE sizeof("4294967295")
+
 #define STA_READ(name, field, format_string)                \
 static ssize_t sta_ ##name## _read(struct file *file,            \
                    char __user *userbuf,        \
@@ -490,6 +493,60 @@ static ssize_t sta_vht_capa_read(struct
 STA_OPS(vht_capa);


+static ssize_t sta_def_thr_read(struct file *file, char __user *userbuf,
+                 size_t count, loff_t *ppos)
+{
+    int ret =3D 0;
+    char buf[DEF_THR_BUFF_SIZE] =3D { 0 };
+    struct sta_info *sta =3D file->private_data;
+
+    rcu_read_lock();
+
+    // Access synchronization to struct sta_info is documented in
net/mac80211/sta_info.c:34
+    ret =3D snprintf(buf, DEF_THR_BUFF_SIZE - 1, "%u", sta->def_thr);
+
+    rcu_read_unlock();
+
+    if(ret >=3D DEF_THR_BUFF_SIZE)
+        return -EFAULT;
+
+    buf[DEF_THR_BUFF_SIZE - 1] =3D '\0';
+
+    return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+}
+
+static ssize_t sta_def_thr_write(struct file *file, const char __user *use=
rbuf,
+                 size_t count, loff_t *ppos)
+{
+    u32 thr =3D 0;
+    int ret =3D 0;
+    char buf[DEF_THR_BUFF_SIZE] =3D { 0 };
+    struct sta_info *sta =3D file->private_data;
+
+    if(count >=3D DEF_THR_BUFF_SIZE)
+        return -EINVAL;
+
+    if (copy_from_user(buf, userbuf, count))
+        return -EFAULT;
+
+    buf[DEF_THR_BUFF_SIZE - 1] =3D '\0';
+
+    ret =3D sscanf(buf, "%u", &thr);
+    if(ret !=3D 1)
+        return -EINVAL;
+
+    rcu_read_lock();
+
+    // Access synchronization to struct sta_info is documented in
net/mac80211/sta_info.c:34
+    sta->def_thr =3D thr;
+    ieee80211_sta_set_expected_throughput(&sta->sta, thr);
+
+    rcu_read_unlock();
+
+    return count;
+}
+STA_OPS_RW(def_thr);
+
 #define DEBUGFS_ADD(name) \
     debugfs_create_file(#name, 0400, \
         sta->debugfs_dir, sta, &sta_ ##name## _ops);
@@ -534,6 +591,7 @@ void ieee80211_sta_debugfs_add(struct st
     DEBUGFS_ADD(agg_status);
     DEBUGFS_ADD(ht_capa);
     DEBUGFS_ADD(vht_capa);
+    DEBUGFS_ADD(def_thr);

     DEBUGFS_ADD_COUNTER(rx_duplicates, rx_stats.num_duplicates);
     DEBUGFS_ADD_COUNTER(rx_fragments, rx_stats.fragments);
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2305,6 +2305,9 @@ u32 sta_get_expected_throughput(struct s
     else
         thr =3D drv_get_expected_throughput(local, sta);

+    if(thr =3D=3D 0 && sta->def_thr !=3D 0)
+        thr =3D sta->def_thr;
+
     return thr;
 }

--- b/net/mac80211/sta_info.h
+++ a/net/mac80211/sta_info.h
@@ -509,6 +509,7 @@
     struct work_struct drv_deliver_wk;

     u16 listen_interval;
+    u32 def_thr;

     bool dead;
     bool removed;



Best Regards,
Lukonin Kirill

=D0=BF=D0=BD, 10 =D0=B8=D1=8E=D0=BD. 2019 =D0=B3. =D0=B2 08:32, Marek Lindn=
er <mareklindner@neomailbox.ch>:
>
> On Sunday, 9 June 2019 20:45:06 HKT Ren=C3=A9 Treffer wrote:
> > I am testing this on devices with ath9k (2.4GHz) and ath10k (5GHz), so =
I
> > was looking at the estimates I get from ath9k. Here is a dump from my
> >
> > home network on 2.4GHz/ath9k and what rx/3 would give us:
> > > signal  tx     rx     expect  tx/3    min(tx/3,(rx+tx)/2/3)
> > > -77     13.0   43.3   6.682   4.333
> > > -57     130.0  117.0  44.677  43.333  41.166
> > > -53     117.0  130.0  42.388  39.0
> > > -82     43.3   6.5    13.366  14.433  8.3      (!!!)
> > > -63     52.0   86.7   26.733  17.333
> > > -58     130.0  173.3  29.21   43.333            !!!
> > > -82     6.5    43.3   2.197   2.166
> > > -48     104.0  65.0   40.191  34.666  28.166
> > > -69     57.8   13.0   20.49   19.266  11.8
> > > -58     86.7   52.0   33.507  28.9    23.116
> > > -58     52.0   1.0    37.994  17.333  8.833
> > > -56     115.6  144.4  29.21   38.533            !!!
>
>
> To confirm my understanding: What this table shows are raw tx/rx link est=
imated
> values ? None of these numbers compares to Minstrel HT expected throughpu=
t or
> actual throughput ?
>
>
> > Cases where the rx/tx estimate would be higher are marked with !!!.
>
> I also don't quite understand what the '!!!' thing is trying to indicate.=
 What
> is being compared ? But it may be due to my misunderstandings above.
>
> In my small test setup with one ath10k device meshing with ath9k over 2.4=
GHz,
> your tx / 3 formula seems to be quite accurate (had removed the rx part).
>
> # batctl o (your magic formula)
> * ac:86:74:00:38:06    0.930s (       45.7)  ac:86:74:00:38:06 [    mesh2=
4]
>
> # batctl tp ac:86:74:00:38:06 (actual throughput)
> Test duration 10440ms.
> Sent 58393512 Bytes.
> Throughput: 5.33 MB/s (44.75 Mbps)
>
> What would be interesting is how the numbers produced by 'tx / 3' compare=
 to
> either the actual throughput (can easily be tested with the throughput me=
ter)
> or Minstrel expected throughput.
>
>
> > Why bother and look at rx at all? Asymmetric routing should already
> > work. I was bit concerned about highly asymmetric links, especially
> > those where the path back might not work. It might not be worth it thou=
gh.
>
> Generally, the return path might be entirely different. Batman-adv does n=
ot
> enforce or even endorse symetric paths. If there is better path for the r=
eturn
> route, batman-adv will choose the better path based on tx from the sender=
 and
> if only one return path exists, we don't care anyway ..
>
> Cheers,
> Marek
