Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 28 Feb 2010 04:30:09 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201002280430.09575.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] reorganized kernel interface
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


Hi folks,

during the last batman developer meeting in Bruxelles we decided that it is 
time to reorganize the batman-adv kernel interface to address numerous issues 
and feature requests we have been hearing about throughout the last year. The 
required changes are extensive, therefore it will take a while to get it all 
sorted out.

Specifically we are targeting the following items:
* People with larger layer2 meshes have expressed the idea of having multiple 
meshes running on the same device in order to build a node which sits 
inbetween 2 (or more) mesh networks and routes the traffic from one to the other 
(thereby reducing the overhead). Due to code limitations batman-adv can only 
create a single mesh on a machine. There are numerous global variables and 
functions that need to be modfied in order to support multiple meshes.

* Despite the fact that we have a growing number of events which would allow 
user space applications to implement some intelligence to improve the mesh 
experience batman-adv has no way of communicating these events back to 
applications. To address this issue we will be moving batman-adv from /proc to 
sysfs which empowers batman-adv to trigger uevents that can be handled from 
user space.

* Since batman-adv's existence its parameter always were configurable using 
simple commands like echo or cat. Although this interface was easy it is not 
possible to direct error messages back to the shell, In case you misspelled a 
parameter you had to check the system logs to learn about it. The following 
patch introduces a way of exporting "allowed values", so that user space 
applications can parse it and alert the user immediately. See batctl as an 
example.

Please review and comment the following patches. As soon as those were 
digested I will send more.

Known issues:
* When sending a wrong input value to aggregate_ogm or bonding the kernel 
processes the input 3 times.

Cheers,
Marek

