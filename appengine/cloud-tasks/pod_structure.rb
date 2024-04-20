# frozen_string_literal: true

def pod
  {
    metadata: {
      name: "vbl-sphinx-d45b489d-gz7g8",
      generateName: "vbl-sphinx-d45b489d-",
      namespace: "development",
      uid: "e3386f48-2951-4313-97c3-bedd4eab3e56",
      resourceVersion: "992807347",
      creationTimestamp: "2024-04-19T11:23:08Z",
      labels: {
        "has-vbl-image": "true",
        "nightly-restart": "true",
        "pod-template-hash": "d45b489d",
        role: "vbl-sphinx"
      },
      ownerReferences: [
        {
          apiVersion: "apps/v1",
          kind: "ReplicaSet",
          name: "vbl-sphinx-d45b489d",
          uid: "8f840fe9-b0de-4e6a-86ad-ddb86889faf7",
          controller: true,
          blockOwnerDeletion: true
        }
      ],
      managedFields: [
        {
          manager: "kube-controller-manager",
          operation: "Update",
          apiVersion: "v1",
          time: "2024-04-19T11:23:08Z",
          fieldsType: "FieldsV1",
          fieldsV1: {
            "f:metadata": {
              "f:generateName": {},
              "f:labels": {
                ".": {},
                "f:has-vbl-image": {},
                "f:nightly-restart": {},
                "f:pod-template-hash": {},
                "f:role": {}
              },
              "f:ownerReferences": {
                ".": {},
                "k:{\"uid\":\"8f840fe9-b0de-4e6a-86ad-ddb86889faf7\"}": {}
              }
            },
            "f:spec": {
              "f:containers": {
                "k:{\"name\":\"vbl-sphinx\"}": {
                  ".": {},
                  "f:command": {},
                  "f:env": {
                    ".": {},
                    "k:{\"name\":\"BS_API_KEY\"}": {
                      ".": {},
                      "f:name": {},
                      "f:valueFrom": {
                        ".": {},
                        "f:secretKeyRef": {}
                      }
                    },
                    "k:{\"name\":\"BS_API_SECRET\"}": {
                      ".": {},
                      "f:name": {},
                      "f:valueFrom": {
                        ".": {},
                        "f:secretKeyRef": {}
                      }
                    },
                    "k:{\"name\":\"BS_BASE_URL\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"QUEUES\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"RAILS_DB_HOST\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"RAILS_DB_NAME\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"RAILS_DB_PASSWORD\"}": {
                      ".": {},
                      "f:name": {},
                      "f:valueFrom": {
                        ".": {},
                        "f:secretKeyRef": {}
                      }
                    },
                    "k:{\"name\":\"RAILS_DB_PORT\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"RAILS_DB_USERNAME\"}": {
                      ".": {},
                      "f:name": {},
                      "f:valueFrom": {
                        ".": {},
                        "f:secretKeyRef": {}
                      }
                    },
                    "k:{\"name\":\"RAILS_ENV\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"RAILS_MEMCACHED_HOST\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"RAILS_MEMCACHED_PORT\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"RAILS_SPHINX_HOST\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"RAILS_SPHINX_PORT\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"SENTRY_DSN\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"SERVER_ROLE\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"SPHINX_CONFIG_PATH\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"SPHINX_INTERVAL_TIME\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"STAGE_NAME\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"TZ\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    }
                  },
                  "f:image": {},
                  "f:imagePullPolicy": {},
                  "f:livenessProbe": {
                    ".": {},
                    "f:exec": {
                      ".": {},
                      "f:command": {}
                    },
                    "f:failureThreshold": {},
                    "f:initialDelaySeconds": {},
                    "f:periodSeconds": {},
                    "f:successThreshold": {},
                    "f:timeoutSeconds": {}
                  },
                  "f:name": {},
                  "f:ports": {
                    ".": {},
                    "k:{\"containerPort\":9312,\"protocol\":\"TCP\"}": {
                      ".": {},
                      "f:containerPort": {},
                      "f:protocol": {}
                    }
                  },
                  "f:resources": {},
                  "f:terminationMessagePath": {},
                  "f:terminationMessagePolicy": {},
                  "f:volumeMounts": {
                    ".": {},
                    "k:{\"mountPath\":\"/opt/app-root/searchd\"}": {
                      ".": {},
                      "f:mountPath": {},
                      "f:name": {}
                    },
                    "k:{\"mountPath\":\"/opt/app-root/src/config/settings.local.yml\"}": {
                      ".": {},
                      "f:mountPath": {},
                      "f:name": {},
                      "f:subPath": {}
                    }
                  }
                }
              },
              "f:dnsPolicy": {},
              "f:enableServiceLinks": {},
              "f:initContainers": {
                ".": {},
                "k:{\"name\":\"wait-for-migrations\"}": {
                  ".": {},
                  "f:command": {},
                  "f:env": {
                    ".": {},
                    "k:{\"name\":\"BS_API_KEY\"}": {
                      ".": {},
                      "f:name": {},
                      "f:valueFrom": {
                        ".": {},
                        "f:secretKeyRef": {}
                      }
                    },
                    "k:{\"name\":\"BS_API_SECRET\"}": {
                      ".": {},
                      "f:name": {},
                      "f:valueFrom": {
                        ".": {},
                        "f:secretKeyRef": {}
                      }
                    },
                    "k:{\"name\":\"BS_BASE_URL\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"QUEUES\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"RAILS_DB_HOST\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"RAILS_DB_NAME\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"RAILS_DB_PASSWORD\"}": {
                      ".": {},
                      "f:name": {},
                      "f:valueFrom": {
                        ".": {},
                        "f:secretKeyRef": {}
                      }
                    },
                    "k:{\"name\":\"RAILS_DB_PORT\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"RAILS_DB_USERNAME\"}": {
                      ".": {},
                      "f:name": {},
                      "f:valueFrom": {
                        ".": {},
                        "f:secretKeyRef": {}
                      }
                    },
                    "k:{\"name\":\"RAILS_ENV\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"RAILS_MEMCACHED_HOST\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"RAILS_MEMCACHED_PORT\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"RAILS_SPHINX_HOST\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"RAILS_SPHINX_PORT\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"SENTRY_DSN\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"SERVER_ROLE\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"SPHINX_CONFIG_PATH\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"SPHINX_INTERVAL_TIME\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"STAGE_NAME\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    },
                    "k:{\"name\":\"TZ\"}": {
                      ".": {},
                      "f:name": {},
                      "f:value": {}
                    }
                  },
                  "f:image": {},
                  "f:imagePullPolicy": {},
                  "f:name": {},
                  "f:resources": {},
                  "f:terminationMessagePath": {},
                  "f:terminationMessagePolicy": {}
                }
              },
              "f:restartPolicy": {},
              "f:schedulerName": {},
              "f:securityContext": {
                ".": {},
                "f:fsGroup": {}
              },
              "f:terminationGracePeriodSeconds": {},
              "f:volumes": {
                ".": {},
                "k:{\"name\":\"searchd-storage\"}": {
                  ".": {},
                  "f:gcePersistentDisk": {
                    ".": {},
                    "f:fsType": {},
                    "f:pdName": {}
                  },
                  "f:name": {}
                },
                "k:{\"name\":\"vbl-settings\"}": {
                  ".": {},
                  "f:configMap": {
                    ".": {},
                    "f:defaultMode": {},
                    "f:items": {},
                    "f:name": {}
                  },
                  "f:name": {}
                }
              }
            }
          }
        },
        {
          manager: "kubelet",
          operation: "Update",
          apiVersion: "v1",
          time: "2024-04-19T11:23:41Z",
          fieldsType: "FieldsV1",
          fieldsV1: {
            "f:status": {
              "f:conditions": {
                "k:{\"type\":\"ContainersReady\"}": {
                  ".": {},
                  "f:lastProbeTime": {},
                  "f:lastTransitionTime": {},
                  "f:status": {},
                  "f:type": {}
                },
                "k:{\"type\":\"Initialized\"}": {
                  ".": {},
                  "f:lastProbeTime": {},
                  "f:lastTransitionTime": {},
                  "f:status": {},
                  "f:type": {}
                },
                "k:{\"type\":\"Ready\"}": {
                  ".": {},
                  "f:lastProbeTime": {},
                  "f:lastTransitionTime": {},
                  "f:status": {},
                  "f:type": {}
                }
              },
              "f:containerStatuses": {},
              "f:hostIP": {},
              "f:initContainerStatuses": {},
              "f:phase": {},
              "f:podIP": {},
              "f:podIPs": {
                ".": {},
                "k:{\"ip\":\"10.0.0.202\"}": {
                  ".": {},
                  "f:ip": {}
                }
              },
              "f:startTime": {}
            }
          },
          subresource: "status"
        }
      ]
    },
    spec: {
      volumes: [
        {
          name: "searchd-storage",
          gcePersistentDisk: {
            pdName: "development-searchd-disk",
            fsType: "ext4"
          }
        },
        {
          name: "vbl-settings",
          configMap: {
            name: "vbl-settings",
            items: [
              {
                key: "settings.local.yml",
                path: "settings.local.yml"
              }
            ],
            defaultMode: 420
          }
        }
      ],
      initContainers: [{
        name: "wait-for-migrations",
        image: "eu.gcr.io/api-project-1016687514786/swissunihockey/vbl-rails:development",
        command: ["bash", "-c", "rails bleib:wait_for_migrations"],
        env: [
          { name: "STAGE_NAME", value: "development" },
          { name: "SERVER_ROLE", value: "sphinx" },
          { name: "RAILS_ENV", value: "staging" },
          { name: "BS_BASE_URL", value: "https://api-v2-dev.swissunihockey.ch/api" },
          { name: "TZ", value: "Europe/Berlin" },
          { name: "RAILS_DB_HOST", value: "postgres" },
          { name: "RAILS_DB_PORT", value: "5432" },
          { name: "RAILS_DB_NAME", value: "swissunihockey" },
          { name: "RAILS_DB_USERNAME", valueFrom: { secretKeyRef: { name: "database-credentials", key: "username" } } },
          { name: "RAILS_DB_PASSWORD", valueFrom: { secretKeyRef: { name: "database-credentials", key: "password" } } },
          { name: "RAILS_MEMCACHED_HOST", value: "memcached" },
          { name: "RAILS_MEMCACHED_PORT", value: "11211" },
          { name: "RAILS_SPHINX_HOST", value: "0.0.0.0" },
          { name: "RAILS_SPHINX_PORT", value: "9312" },
          { name: "SPHINX_INTERVAL_TIME", value: "7200" },
          { name: "SPHINX_CONFIG_PATH", value: "/opt/app-root/searchd/sphinx.conf" },
          { name: "QUEUES", value: "delayed_delta" },
          { name: "SENTRY_DSN", value: "https://d43000604a0a438989b18e12750ce2ba:39fdd38d4e6c4d03a46cc9e1fcbb7b80@sentry.puzzle.ch/42" },
          { name: "BS_API_KEY", valueFrom: { secretKeyRef: { name: "vbl-bs-credentials", key: "api-key" } } },
          { name: "BS_API_SECRET", valueFrom: { secretKeyRef: { name: "vbl-bs-credentials", key: "api-secret" } } }
        ],
        resources: {},
        terminationMessagePath: "/dev/termination-log",
        terminationMessagePolicy: "File",
        imagePullPolicy: "Always"
      }],
      containers: [
        {
          name: "vbl-sphinx",
          image: "eu.gcr.io/api-project-1016687514786/swissunihockey/vbl-rails:development",
          command: ["bash", "-c", "mkdir -p /opt/app-root/src/log && \\\n/usr/libexec/s2i/run-sphinx"],
          ports: [
            {
              containerPort: 9312,
            protocol: "TCP"
            }
          ],
          env: [
            { name: "STAGE_NAME", value: "development" },
            { name: "SERVER_ROLE", value: "sphinx" },
            { name: "RAILS_ENV", value: "staging" },
            { name: "BS_BASE_URL", value: "https://api-v2-dev.swissunihockey.ch/api" },
            { name: "TZ", value: "Europe/Berlin" },
            { name: "RAILS_DB_HOST", value: "postgres" },
            { name: "RAILS_DB_PORT", value: "5432" },
            { name: "RAILS_DB_NAME", value: "swissunihockey" },
            {
              name: "RAILS_DB_USERNAME",
              valueFrom: {
                secretKeyRef: {
                  name: "database-credentials",
                  key: "username"
                }
              }
            },
            {
              name: "RAILS_DB_PASSWORD",
              valueFrom: {
                secretKeyRef: {
                  name: "database-credentials",
                  key: "password"
                }
              }
            },
            { name: "RAILS_MEMCACHED_HOST", value: "memcached" },
            { name: "RAILS_MEMCACHED_PORT", value: "11211" },
            { name: "RAILS_SPHINX_HOST", value: "0.0.0.0" },
            { name: "RAILS_SPHINX_PORT", value: "9312" },
            { name: "SPHINX_INTERVAL_TIME", value: "7200" },
            { name: "SPHINX_CONFIG_PATH", value: "/opt/app-root/searchd/sphinx.conf" },
            { name: "QUEUES", value: "delayed_delta" },
            { name: "SENTRY_DSN", value: "https://d43000604a0a438989b18e12750ce2ba:39fdd38d4e6c4d03a46cc9e1fcbb7b80@sentry.puzzle.ch/42" },
            {
              name: "BS_API_KEY",
              valueFrom: {
                secretKeyRef: {
                  name: "vbl-bs-credentials",
                  key: "api-key"
                }
              }
            },
            {
              name: "BS_API_SECRET",
              valueFrom: {
                secretKeyRef: {
                  name: "vbl-bs-credentials",
                  key: "api-secret"
                }
              }
            }
          ],
          resources: {},
          volumeMounts: [
            {
              name: "vbl-settings",
              mountPath: "/opt/app-root/src/config/settings.local.yml",
              subPath: "settings.local.yml"
            },
            {
              name: "searchd-storage",
              mountPath: "/opt/app-root/searchd"
            }
          ],
          livenessProbe: {
            exec: { command: ["bash", "/usr/libexec/s2i/k8s-sphinx-liveness-check"] },
            initialDelaySeconds: 30,
            timeoutSeconds: 1,
            periodSeconds: 10,
            successThreshold: 1,
            failureThreshold: 3
          },
          terminationMessagePath: "/dev/termination-log",
          terminationMessagePolicy: "File",
          imagePullPolicy: "Always"
        }
      ],
      restartPolicy: "Always",
      terminationGracePeriodSeconds: 30,
      dnsPolicy: "ClusterFirst",
      serviceAccountName: "default",
      serviceAccount: "default",
      nodeName: "gke-genesis-pool-5-containerd-7cffc241-rpw1",
      securityContext: {
        fsGroup: 1001
      },
      schedulerName: "default-scheduler",
      tolerations: [
        {
          key: "node.kubernetes.io/not-ready",
          operator: "Exists",
          effect: "NoExecute",
          tolerationSeconds: 300
        },
        {
          key: "node.kubernetes.io/unreachable",
          operator: "Exists",
          effect: "NoExecute",
          tolerationSeconds: 300
        }
      ],
      priority: 0,
      enableServiceLinks: true,
      preemptionPolicy: "PreemptLowerPriority"
    },
    status: {
      phase: "Running",
      conditions: [
        {
          type: "Initialized",
          status: "True",
          lastProbeTime: nil,
          lastTransitionTime: "2024-04-19T11:23:40Z"
        },
        {
          type: "Ready",
          status: "True",
          lastProbeTime: nil,
          lastTransitionTime: "2024-04-19T11:23:41Z"
        },
        {
          type: "ContainersReady",
          status: "True",
          lastProbeTime: nil,
          lastTransitionTime: "2024-04-19T11:23:41Z"
        },
        {
          type: "PodScheduled",
          status: "True",
          lastProbeTime: nil,
          lastTransitionTime: "2024-04-19T11:23:08Z"
        }
      ],
      hostIP: "10.132.0.43",
      podIP: "10.0.0.202",
      podIPs: [{ ip: "10.0.0.202" }],
      startTime: "2024-04-19T11:23:08Z",
      initContainerStatuses: [
        {
          name: "wait-for-migrations",
          state: {
            terminated: {
              exitCode: 0,
              reason: "Completed",
              startedAt: "2024-04-19T11:23:33Z",
              finishedAt: "2024-04-19T11:23:39Z",
              containerID: "containerd://f41603ec4042ebf6b45a59480f54cf20f543efc9447b0fc12f4a68e8cad32ca0"
            }
          },
          lastState: {},
          ready: true,
          restartCount: 0,
          image: "eu.gcr.io/api-project-1016687514786/swissunihockey/vbl-rails:development",
          imageID: "eu.gcr.io/api-project-1016687514786/swissunihockey/vbl-rails@sha256:ec61c11aaf4b051413f45e3813a77d16b72e3be6c420794f18803649c496b1b7",
          containerID: "containerd://f41603ec4042ebf6b45a59480f54cf20f543efc9447b0fc12f4a68e8cad32ca0",
          started: false
        }
      ],
      containerStatuses: [
        {
          name: "vbl-sphinx",
          state: {
            running: { startedAt: "2024-04-19T11:23:41Z" }
          },
          lastState: {},
          ready: true,
          restartCount: 0,
          image: "eu.gcr.io/api-project-1016687514786/swissunihockey/vbl-rails:development",
          imageID: "eu.gcr.io/api-project-1016687514786/swissunihockey/vbl-rails@sha256:ec61c11aaf4b051413f45e3813a77d16b72e3be6c420794f18803649c496b1b7",
          containerID: "containerd://35344b587c0426e611b00f45488f702f0e3913335091ef7e53f71adf7984617a",
          started: true
        }
      ],
      qosClass: "BestEffort"
    },
    apiVersion: "v1",
    kind: "Pod"
  }
end
